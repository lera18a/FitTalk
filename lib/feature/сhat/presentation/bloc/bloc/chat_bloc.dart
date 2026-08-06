import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/repository/chat_repository.dart';
import 'package:fit_talk/feature/friends/domain/model/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;
  final String _currentUserId;
  String _chatId = '';
  StreamSubscription<MessageModel>? _messagesSubscription;

  ChatBloc({required ChatRepository repository, required String currentUserId})
    : _repository = repository,
      _currentUserId = currentUserId,
      super(const ChatState.initial()) {
    on<_LoadMessages>(_onLoadMessages);
    on<_SendMessage>(_onSendMessage);
    on<_MessageReceived>(_onMessageReceived);
  }
  Future<void> _onLoadMessages(
    _LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    _chatId = event.chatId;
    emit(const ChatState.loading());

    await _messagesSubscription?.cancel();

    final result = await _repository.getMessages(_chatId);

    result.fold((failure) => emit(ChatState.failure(failure.message)), (
      messages,
    ) {
      emit(ChatState.loaded(messages, false, ''));

      // Слушаем стрим изменений таблицы messages в реальном времени
      _messagesSubscription = _repository.subscribeToMessages(_chatId).listen((
        message,
      ) {
        add(ChatEvent.messageReceived(message));
      });
    });
  }

  Future<void> _onSendMessage(
    _SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    if (_chatId.isEmpty || _currentUserId.isEmpty) {
      emit(currentState.copyWith(error: 'Чат не инициализирован'));
      return;
    }

    final result = await _repository.sendMessage(
      MessageModel(
        id: '',
        chatId: _chatId,
        senderId: _currentUserId,
        senderName: '',
        text: event.text,
        createdAt: DateTime.now(),
      ),
    );

    result.fold(
      (failure) => emit(currentState.copyWith(error: failure.message)),
      (_) {},
    );
  }

  void _onMessageReceived(_MessageReceived event, Emitter<ChatState> emit) {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final exists = currentState.messages.any((m) => m.id == event.message.id);
    if (exists) return;

    final updatedMessages = List<MessageModel>.from(currentState.messages)
      ..add(event.message);

    emit(currentState.copyWith(messages: updatedMessages));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
