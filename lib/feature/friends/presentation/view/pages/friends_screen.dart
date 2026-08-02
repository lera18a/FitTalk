import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/friends/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Пользователи')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Поиск по имени или нику',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<FriendsBloc>().add(
                  FriendsEvent.searchChanged(value),
                );
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<FriendsBloc, FriendsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(child: Text(state.error!));
                  }

                  if (state.users.isEmpty) {
                    return const Center(child: Text('Пользователи не найдены'));
                  }

                  return ListView.separated(
                    itemCount: state.users.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final user = state.users[index];

                      return _UserTile(user: user);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user});

  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          debugPrint('USER ID = ${user.id}');
          context.router.root.push(ProfileInfoRoute(userId: user.id));
        },
        leading: CircleAvatar(
          backgroundImage: user.avatarUrl != null
              ? NetworkImage(user.avatarUrl!)
              : null,
          child: user.avatarUrl == null ? const Icon(Icons.person) : null,
        ),
        title: Text(user.firstName ?? ''),
        subtitle: Text('@${user.username ?? ''}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
