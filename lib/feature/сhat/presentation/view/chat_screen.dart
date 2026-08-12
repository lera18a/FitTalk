import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fit_talk/core/widgets/online_status_indicator.dart';
import 'package:fit_talk/core/services/status_realtime_service.dart';
import 'package:fit_talk/feature/сhat/presentation/bloc/bloc/chat_bloc.dart';
import 'package:fit_talk/feature/сhat/domain/repository/chat_repository.dart';
import 'package:fit_talk/feature/friends/domain/model/message_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final currentUserId = Supabase.instance.client.auth.currentUser?.id ?? '';
    return BlocProvider(
      create: (context) => ChatBloc(
        repository: context.read<ChatRepository>(),
        currentUserId: currentUserId,
      )..add(ChatEvent.loadMessages(chatId)),
      child: _ChatView(chatId: chatId, currentUserId: currentUserId),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.chatId, required this.currentUserId});

  final String chatId;
  final String currentUserId;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  // Для статуса онлайн
  DateTime? _partnerLastSeen;
  String _partnerName = 'Диалог';
  String? _partnerId;
  StreamSubscription? _statusSubscription;
  Timer? _statusRefreshTimer;

  @override
  void initState() {
    super.initState();
    _loadPartnerInfo();

    // Обновляем таймер каждые 15 секунд
    _statusRefreshTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _loadPartnerInfo() async {
    try {
      debugPrint(
        '🔎 [ChatScreen] Запрос партнера через RPC для chatId: ${widget.chatId}',
      );

      final response = await Supabase.instance.client.rpc(
        'get_chat_partner_info',
        params: {'p_chat_id': widget.chatId},
      );

      if (response == null || (response as List).isEmpty) {
        debugPrint('⚠️ [ChatScreen] Партнер не найден');
        return;
      }

      final data = (response as List).first as Map<String, dynamic>;
      final partnerId = data['partner_id'] as String;
      final partnerName = data['partner_name'] as String? ?? 'Диалог';
      final rawLastSeen = data['partner_last_seen'];
      final parsedLastSeen = rawLastSeen != null
          ? DateTime.parse(rawLastSeen.toString())
          : null;

      debugPrint(
        '✅ [ChatScreen] УСПЕХ! Партнер: $partnerName, lastSeen: $parsedLastSeen',
      );

      if (mounted) {
        setState(() {
          _partnerId = partnerId;
          _partnerName = partnerName;
          _partnerLastSeen = parsedLastSeen;
        });
      }

      // Подписываемся на мгновенные Realtime изменения статуса
      _subscribeToStatus(partnerId);
    } catch (e, stackTrace) {
      debugPrint('💥 [ChatScreen] Ошибка RPC: $e');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  void _subscribeToStatus(String partnerId) {
    _statusSubscription?.cancel();

    _statusSubscription = StatusRealtimeService().subscribeToUserStatus(
      userId: partnerId,
      onStatusChanged: (lastSeen) {
        debugPrint('🔔 [ChatScreen] Realtime статус изменился: $lastSeen');
        if (mounted) {
          setState(() {
            _partnerLastSeen = lastSeen;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _statusSubscription?.cancel();
    _statusRefreshTimer?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(ChatEvent.sendMessage(text));
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _partnerName,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            OnlineStatusIndicator(
              lastSeen: _partnerLastSeen,
              showText: true,
              size: 8,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.runtimeType.toString() == '_Loading') {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.runtimeType.toString() == '_Failure') {
                  return Center(
                    child: Text((state as dynamic).message ?? 'Ошибка'),
                  );
                }

                if (state.runtimeType.toString() == '_Loaded') {
                  final messages =
                      (state as dynamic).messages as List<MessageModel>;

                  if (messages.isNotEmpty) {
                    _scrollToBottom();
                  }

                  if (messages.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Начните диалог',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: false,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      final msg = messages[i];
                      final isMe = msg.senderId == widget.currentUserId;
                      return _buildMessageBubble(
                        text: msg.text,
                        isMe: isMe,
                        time: msg.createdAt,
                        theme: theme,
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          _buildInputBar(theme),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String text,
    required bool isMe,
    required DateTime time,
    required ThemeData theme,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? theme.colorScheme.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? theme.colorScheme.onPrimary : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(time),
              style: TextStyle(
                fontSize: 11,
                color: isMe
                    ? theme.colorScheme.onPrimary.withOpacity(0.7)
                    : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(ThemeData theme) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Сообщение...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
