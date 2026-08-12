import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/core/widgets/online_status_indicator.dart';
import 'package:fit_talk/feature/%D1%81hat/domain/repository/chat_repository.dart';
import 'package:fit_talk/feature/friends/presentation/bloc/profile_info_bloc/profile_info_bloc.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
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
      child: _ProfileInfoView(userId: userId),
    );
  }
}

class _ProfileInfoView extends StatelessWidget {
  const _ProfileInfoView({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (message) => Center(child: Text(message)),
            loaded: (profile) => _buildProfileContent(context, profile),
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileModel profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage:
                profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty
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
          OnlineStatusIndicator(
            lastSeen: profile.lastSeen, // нужно добавить в ChatPreviewModel
            showText: true,
          ),
          const SizedBox(height: 8),
          Text(
            '@${profile.username ?? ''}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          if (profile.bio != null && profile.bio!.trim().isNotEmpty) ...[
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'О себе',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: Text(profile.bio!)),
          ],
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              // ✅ Навигация напрямую в onPressed
              onPressed: () async {
                final result = await context
                    .read<ChatRepository>()
                    .createOrGetPrivateChat(profile.id);

                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: ${failure.message}')),
                    );
                  },
                  (chatId) {
                    context.router.root.push(ChatRoute(chatId: chatId));
                  },
                );
              },
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Написать'),
            ),
          ),
        ],
      ),
    );
  }
}
