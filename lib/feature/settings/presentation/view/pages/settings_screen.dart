import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/feature/settings/presentation/bloc/bloc/settings_profile_bloc.dart';
import 'package:fit_talk/feature/settings/presentation/view/widgets/custom_dialog.dart';
import 'package:fit_talk/feature/settings/presentation/view/widgets/custom_sliver_app_bar.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static List<({IconData icon, String title})> _menuItems(
    BuildContext context,
  ) => [
    (icon: Icons.color_lens_outlined, title: 'Цвет профиля'),
    (icon: Icons.add_a_photo_outlined, title: 'Фото профиля'),
    (icon: Icons.person, title: 'Профиль'),
    (icon: Icons.bookmark, title: 'Сохраненные'),
    (icon: Icons.lock, title: 'Безопасность'),
    (icon: Icons.notifications, title: 'Уведомления'),
    (icon: Icons.language, title: 'Язык'),
    (icon: Icons.palette, title: 'Темы'),
    (icon: Icons.info, title: 'О приложении'),
  ];

  @override
  Widget build(BuildContext context) {
    final menuItems = _menuItems(context);

    return Scaffold(
      body: BlocBuilder<SettingsProfileBloc, SettingsProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (msg) => Center(child: Text(msg)),

            // ── loaded — здесь profile доступен сразу ──
            loaded: (profile) => CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  expandedHeight: 300,
                  title: profile.firstName ?? 'Пользователь',
                  avatarImage: profile.avatarUrl != null
                      ? SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipOval(
                            child: Image.network(
                              profile.avatarUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(Icons.person, size: 50),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      onPressed: () async {
                        final response = await showDialog<bool>(
                          context: context,
                          builder: (context) => const CustomDialog(),
                        );
                        if (response == true && context.mounted) {
                          context.read<AuthBloc>().add(LogOut());
                        }
                      },
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = menuItems[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(item.icon),
                          title: Text(item.title),
                          trailing: const Icon(Icons.chevron_right, size: 18),
                          onTap: () {
                            if (item.title == 'Фото профиля') {
                              context.router.push(ProfilePhotoRoute());
                            }
                          },
                        ),
                        const Divider(height: 1),
                      ],
                    );
                  }, childCount: menuItems.length),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
