import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/%D1%81hat/data/datasource/chat_datasource.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/model/chat_preview.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/repository/chat_repository.dart';
import 'package:fit_talk/feature/friends/domain/model/message_model.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._datasource);

  final ChatDatasource _datasource;

  @override
  Future<Either<AppFailure, String>> createOrGetPrivateChat(
    String otherUserId,
  ) async {
    try {
      final chatId = await _datasource.getOrCreatePrivateChat(otherUserId);

      return right(chatId);
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<AppFailure, List<MessageModel>>> getMessages(
    String chatId,
  ) async {
    try {
      return right(await _datasource.getMessages(chatId));
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<AppFailure, void>> sendMessage(MessageModel message) async {
    try {
      await _datasource.sendMessage(message);
      return right(null);
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Stream<MessageModel> subscribeToMessages(String chatId) {
    return _datasource.subscribeToMessages(chatId);
  }

  Future<Either<AppFailure, List<ChatPreviewModel>>> getMyPrivateChats(
    String currentUserId,
  ) async {
    try {
      return right(await _datasource.getMyPrivateChats(currentUserId));
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  Stream<String> subscribeToChatsUpdates() {
    return _datasource.subscribeToChatsUpdates();
  }
}
