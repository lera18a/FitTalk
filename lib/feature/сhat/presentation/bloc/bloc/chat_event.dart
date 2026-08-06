part of 'chat_bloc.dart';

@freezed
abstract class ChatEvent with _$ChatEvent {
  const factory ChatEvent.loadMessages(String chatId) = _LoadMessages;
  const factory ChatEvent.sendMessage(String text) = _SendMessage;
  const factory ChatEvent.messageReceived(MessageModel message) =
      _MessageReceived;
}
