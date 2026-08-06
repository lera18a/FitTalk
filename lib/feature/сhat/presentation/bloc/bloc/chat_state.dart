part of 'chat_bloc.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.failure(String message) = _Failure;
  const factory ChatState.loaded(
    List<MessageModel> messages,
    bool isLoading,
    String? error,
  ) = _Loaded;
}
