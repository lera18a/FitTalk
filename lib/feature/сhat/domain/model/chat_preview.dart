class ChatPreviewModel {
  final String chatId;
  final String otherUserName;
  final String otherUserId;
  final String lastMessage;
  final String? avatarUrl;
  final DateTime lastMessageAt;
  final int unreadCount;

  ChatPreviewModel({
    required this.chatId,
    required this.otherUserName,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.otherUserId,
    required this.avatarUrl,
    required this.unreadCount,
  });
}
