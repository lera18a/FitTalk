import 'package:fit_talk/feature/%D1%81hat/domain/repository/chat_repository.dart';
import 'package:fit_talk/feature/%D1%81hat/presentation/bloc/bloc/chat_bloc.dart';
import 'package:fit_talk/feature/%D1%81hat/presentation/bloc/chat_list_bloc/bloc/chat_list_bloc.dart';
import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/feature/friends/domain/repository/friends_repository.dart';
import 'package:fit_talk/feature/friends/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:fit_talk/feature/settings/theme/presentation/bloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlocInjector extends StatelessWidget {
  const BlocInjector({super.key, required Widget child}) : _child = child;
  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(
          create: (context) => AuthBloc(
            emailValidator: context.read(),
            passwordValidator: context.read(),
            authRepository: context.read(),
            // requestOtpUseCase: context.read(),
            // verifyOtpUseCase: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              FriendsBloc(friendsRepository: context.read<FriendsRepository>()),
        ),

        BlocProvider(
          create: (context) {
            final user = Supabase.instance.client.auth.currentUser;

            if (user == null) {
              throw StateError(
                'ChatBloc создан без авторизованного пользователя',
              );
            }

            return ChatBloc(
              repository: context.read<ChatRepository>(),
              currentUserId: user.id, // <-- гарантированно валидный uuid
            );
          },
        ),
        BlocProvider(
          create: (context) =>
              ChatListBloc(repository: context.read(), client: context.read()),
        ),
        // BlocProvider(
        //   create: (context) => ProfileBloc(profileRepository: context.read()),
        // ),
        // BlocProvider(
        //   create: (context) => SettingsProfileBloc(
        //     profileRepository: context.read<ProfileRepository>(),
        //     client: context.read<SupabaseClient>(),
        //   ),
        // ),
      ],
      child: _child,
    );
  }
}
