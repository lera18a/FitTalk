part of 'chat_list_bloc.dart';

@freezed
class ChatListState with _$ChatListState {
  const factory ChatListState.loading() = _Initial;
  const factory ChatListState.loaded(List<ChatPreviewModel> chats) = _Loaded;
  const factory ChatListState.failure(String message) = _Failure;
}
