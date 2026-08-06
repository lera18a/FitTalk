import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/model/chat_preview.dart';
import 'package:fit_talk/feature/friends/domain/model/message_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChatRepository {
  Future<Either<AppFailure, String>> createOrGetPrivateChat(String otherUserId);
  Future<Either<AppFailure, List<MessageModel>>> getMessages(String chatId);
  Future<Either<AppFailure, void>> sendMessage(MessageModel message);
  Stream<MessageModel> subscribeToMessages(
    String chatId,
  ); // Стрим для Realtimes
  Future<Either<AppFailure, List<ChatPreviewModel>>> getMyPrivateChats(
    String currentUserId,
  );
  Stream<String> subscribeToChatsUpdates();
}
