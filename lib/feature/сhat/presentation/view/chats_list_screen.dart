import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/%D1%81hat/presentation/bloc/chat_list_bloc/bloc/chat_list_bloc.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.router.push(const FriendsRoute()),
          ),
        ],
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (message) => Center(child: Text('Ошибка: $message')),
            loaded: (chats) {
              if (chats.isEmpty) {
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
                        'Пока нет чатов',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ChatListBloc>().add(
                    const ChatListEvent.refresh(),
                  );
                },

                child: ListView.separated(
                  key: ValueKey(chats.length),
                  itemCount: chats.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 72),
                  itemBuilder: (context, i) {
                    final c = chats[i];
                    final time = c.lastMessageAt != null
                        ? _formatTime(c.lastMessageAt!)
                        : '';
                    final hasUnread = c.unreadCount > 0;

                    return ListTile(
                      key: ValueKey(c.chatId),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            c.avatarUrl != null && c.avatarUrl!.isNotEmpty
                            ? NetworkImage(c.avatarUrl!)
                            : null,
                        backgroundColor:
                            c.avatarUrl == null || c.avatarUrl!.isEmpty
                            ? _getColorFromString(c.otherUserName)
                            : null,
                        child: c.avatarUrl == null || c.avatarUrl!.isEmpty
                            ? Text(
                                _getInitials(c.otherUserName),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : null,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.otherUserName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: hasUnread
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                          if (hasUnread)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                c.unreadCount > 99 ? '99+' : '${c.unreadCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Text(
                        c.lastMessage.isEmpty ? 'Нет сообщений' : c.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: hasUnread ? Colors.black87 : Colors.grey[600],
                          fontWeight: hasUnread ? FontWeight.w600 : null,
                        ),
                      ),
                      trailing: time.isNotEmpty
                          ? Text(
                              time,
                              style: TextStyle(
                                color: hasUnread
                                    ? Colors.black87
                                    : Colors.grey[500],
                                fontSize: 12,
                                fontWeight: hasUnread ? FontWeight.w600 : null,
                              ),
                            )
                          : null,
                      onTap: () {
                        context.read<ChatListBloc>().add(
                          ChatListEvent.markAsRead(c.chatId),
                        );
                        context.router.root.push(ChatRoute(chatId: c.chatId));
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return DateFormat('HH:mm').format(dt);
    if (diff.inDays == 1) return 'Вчера';
    if (diff.inDays < 7) return DateFormat('EEE').format(dt);
    return DateFormat('dd.MM').format(dt);
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  Color _getColorFromString(String s) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.red,
    ];
    return colors[s.length % colors.length];
  }
}
