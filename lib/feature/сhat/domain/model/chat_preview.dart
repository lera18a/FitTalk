class ChatPreviewModel {
  final String chatId;
  final String otherUserName;
  final String otherUserId;
  final String lastMessage;
  final String? avatarUrl;
  final DateTime lastMessageAt;
  final int unreadCount;
  final DateTime? partnerLastSeen;

  ChatPreviewModel({
    required this.chatId,
    required this.otherUserName,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.otherUserId,
    required this.avatarUrl,
    required this.unreadCount,
    this.partnerLastSeen,
  });

  // 🛠 ДОБАВЛЯЕМ ПАРСИНГ ИЗ JSON:
  factory ChatPreviewModel.fromJson(Map<String, dynamic> json) {
    dynamic rawLastSeen =
        json['partner_last_seen'] ??
        json['last_seen'] ??
        (json['profiles'] is Map ? json['profiles']['last_seen'] : null);

    return ChatPreviewModel(
      chatId: json['chat_id']?.toString() ?? json['id']?.toString() ?? '',
      otherUserName:
          json['other_user_name'] ?? json['other_user_username'] ?? '',
      otherUserId: json['other_user_id']?.toString() ?? '',
      lastMessage: json['last_message'] ?? '',
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'].toString())
          : DateTime.now(),
      avatarUrl: json['other_user_avatar'] ?? json['avatar_url'],
      unreadCount: json['unread_count'] ?? 0,
      partnerLastSeen: rawLastSeen != null
          ? DateTime.parse(rawLastSeen.toString())
          : null,
    );
  }
}
