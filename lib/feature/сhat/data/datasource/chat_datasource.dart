import 'dart:async';

import 'package:fit_talk/feature/%D1%81hat/domain/model/chat_preview.dart';
import 'package:fit_talk/feature/friends/domain/model/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDatasource {
  ChatDatasource(this._client);

  final SupabaseClient _client;

  Future<String> getOrCreatePrivateChat(String otherUserId) async {
    final chatId = await _client.rpc(
      'get_or_create_private_chat',
      params: {'other_user_id': otherUserId},
    );

    return chatId as String;
  }

  Future<List<MessageModel>> getMessages(String chatId) async {
    final data = await _client
        .from('messages')
        .select('''
        id, chat_id, sender_id, text, created_at,
        profiles:profiles!messages_sender_id_profiles_fkey(first_name, username)
      ''')
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);

    return (data as List).map((row) {
      final user = row['profiles'] as Map<String, dynamic>?;

      final name = '${user?['first_name'] ?? ''} ${user?['username'] ?? ''}'
          .trim();

      return MessageModel(
        id: row['id'] as String,
        chatId: row['chat_id'] as String,
        senderId: row['sender_id'] as String,
        senderName: name.isEmpty ? 'User' : name,
        text: row['text'] as String,
        createdAt: DateTime.parse(row['created_at'] as String).toLocal(),
      );
    }).toList();
  }

  Future<void> sendMessage(MessageModel message) async {
    await _client.from('messages').insert({
      'chat_id': message.chatId,
      'sender_id': message.senderId,
      'text': message.text,
    });
  }

  Stream<MessageModel> subscribeToMessages(String chatId) {
    final controller = StreamController<MessageModel>.broadcast();
    final channel = _client.channel('messages:$chatId');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'chat_id',
        value: chatId,
      ),
      callback: (payload) {
        final row = payload.newRecord;
        controller.add(
          MessageModel(
            id: row['id'] as String,
            chatId: row['chat_id'] as String,
            senderId: row['sender_id'] as String,
            senderName: '',
            text: row['text'] as String,
            createdAt: DateTime.parse(row['created_at'] as String).toLocal(),
          ),
        );
      },
    );

    controller
      ..onListen = channel.subscribe
      ..onCancel = () async {
        await _client.removeChannel(channel);
        await controller.close();
      };

    return controller.stream;
  }

  Future<List<ChatPreviewModel>> getMyPrivateChats(String currentUserId) async {
    final data = await _client.rpc(
      'get_my_private_chats',
      params: {'p_user_id': currentUserId},
    );

    return (data as List).map((row) {
      return ChatPreviewModel(
        chatId: row['chat_id'] as String,
        otherUserName: row['other_user_name'] as String? ?? 'User',
        avatarUrl: row['other_avatar_url'] as String?,
        lastMessage: row['last_message'] as String? ?? '',
        otherUserId: row['other_user_id'] as String,
        lastMessageAt: row['last_message_at'] == null
            ? DateTime.now() // или null, если сделаешь поле nullable
            : DateTime.parse(row['last_message_at'] as String),
        unreadCount: (row['unread_count'] as num?)?.toInt() ?? 0,
        partnerLastSeen: row['partner_last_seen'] != null
            ? DateTime.parse(row['partner_last_seen'].toString())
            : null, // 👈 ВОТ ЭТА СТРОЧКА!
      );
    }).toList();
  }

  Stream<String> subscribeToChatsUpdates() {
    final controller = StreamController<String>.broadcast();
    final channel = _client.channel('chats:updates');

    print('🔔 Подписка на канал chats:updates'); // ✅ 1
    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      callback: (payload) {
        final chatId = payload.newRecord['chat_id'] as String?;
        print(' Realtime callback: chatId = $chatId'); // ✅ 2
        if (chatId != null) {
          controller.add(chatId);
        }
      },
    );

    // ✅ Правильная настройка контроллера
    controller.onListen = () {
      print('🔔 onListen — подписываем канал'); // ✅ 3
      channel.subscribe();
    };

    controller.onCancel = () async {
      print('🔔 onCancel — отписываем канал'); //
      await _client.removeChannel(channel);
      await controller.close();
    };

    return controller.stream;
  }
}
