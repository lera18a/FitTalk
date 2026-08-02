import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/friends/domain/repository/friends_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friends_event.dart';
part 'friends_state.dart';
part 'friends_bloc.freezed.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendsRepository friendsRepository;
  FriendsBloc({required this.friendsRepository})
    : super(_Initial('', [], false, null)) {
    on<_SearchChanged>(_onSearchChanged);
  }
  Future<void> _onSearchChanged(
    _SearchChanged event,
    Emitter<FriendsState> emit,
  ) async {
    emit(state.copyWith(query: event.query, isLoading: true, error: null));

    if (event.query.trim().isEmpty) {
      emit(state.copyWith(users: [], isLoading: false));
      return;
    }

    final result = await friendsRepository.searchUsers(event.query);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (users) {
        emit(state.copyWith(users: users, isLoading: false));
      },
    );
  }
}
