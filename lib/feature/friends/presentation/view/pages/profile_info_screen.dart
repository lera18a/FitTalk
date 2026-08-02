import 'package:fit_talk/feature/friends/presentation/bloc/bloc/profile_info_bloc.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileInfoBloc(repository: context.read<ProfileRepository>())
            ..add(ProfileInfoEvent.loadProfile(userId)),
      child: const _ProfileInfoView(),
    );
  }
}

class _ProfileInfoView extends StatelessWidget {
  const _ProfileInfoView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),

            loading: () => const Center(child: CircularProgressIndicator()),

            failure: (message) => Center(child: Text(message)),

            loaded: (profile) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          profile.avatarUrl != null &&
                              profile.avatarUrl!.isNotEmpty
                          ? NetworkImage(profile.avatarUrl!)
                          : null,
                      child: profile.avatarUrl == null
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      '${profile.firstName ?? ''} ${profile.lastName ?? ''}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '@${profile.username ?? ''}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),

                    if (profile.bio != null &&
                        profile.bio!.trim().isNotEmpty) ...[
                      const SizedBox(height: 32),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'О себе',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(profile.bio!),
                      ),
                    ],

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {
                          // TODO открыть или создать чат
                        },
                        icon: const Icon(Icons.chat_bubble_outline),
                        label: const Text('Написать'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
