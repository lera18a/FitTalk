part of 'chat_list_bloc.dart';

@freezed
class ChatListEvent with _$ChatListEvent {
  const factory ChatListEvent.load() = _Load;
  const factory ChatListEvent.refresh() = _Refresh;
  const factory ChatListEvent.markAsRead(String chatId) = _MarkAsRead;
}
