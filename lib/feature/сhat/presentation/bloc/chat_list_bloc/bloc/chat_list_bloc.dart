import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/model/chat_preview.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/repository/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';
part 'chat_list_bloc.freezed.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _repository;
  final SupabaseClient _client;
  StreamSubscription? _messagesSubscription;

  ChatListBloc({
    required ChatRepository repository,
    required SupabaseClient client,
  }) : _repository = repository,
       _client = client,
       super(const ChatListState.loading()) {
    on<_Load>(_onLoad);
    on<_Refresh>(_onRefresh);
    on<_MarkAsRead>(_onMarkAsRead);
    add(const ChatListEvent.load());
  }
  Future<void> _onLoad(ChatListEvent event, Emitter<ChatListState> emit) async {
    emit(const ChatListState.loading());
    await _messagesSubscription?.cancel();

    final user = _client.auth.currentUser;
    if (user == null) {
      emit(const ChatListState.failure('Не авторизован'));
      return;
    }

    final result = await _repository.getMyPrivateChats(user.id);
    result.fold((failure) => emit(ChatListState.failure(failure.message)), (
      chats,
    ) {
      print('📬 Загружено чатов: ${chats.length}'); // ✅ 5

      emit(ChatListState.loaded(chats));

      // Подписка на новые сообщения
      _messagesSubscription = _repository.subscribeToChatsUpdates().listen((
        chatId,
      ) {
        print('📩 Получен chatId из стрима: $chatId'); // ✅ 6
        add(const ChatListEvent.refresh());
      });
    });
  }

  // ✅ Не переходим в loading, сразу обновляем данные
  Future<void> _onRefresh(
    ChatListEvent event,
    Emitter<ChatListState> emit,
  ) async {
    print(' _onRefresh вызван!'); // ✅ 7
    final user = _client.auth.currentUser;
    if (user == null) return;

    final result = await _repository.getMyPrivateChats(user.id);
    result.fold((failure) => emit(ChatListState.failure(failure.message)), (
      chats,
    ) {
      // ✅ Добавь принт для отладки
      for (var chat in chats) {
        print('Chat: ${chat.otherUserName}, Unread: ${chat.unreadCount}');
      }
      emit(ChatListState.loaded(chats));
    });
  }

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<ChatListState> emit,
  ) async {
    await _client.rpc(
      'reset_unread_count',
      params: {
        'p_chat_id': event.chatId,
        'p_user_id': _client.auth.currentUser!.id,
      },
    );

    add(const ChatListEvent.refresh());
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
