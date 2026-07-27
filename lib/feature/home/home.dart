import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    // required Widget child,
    // int currentIndex = 0,
    // void Function(int)? onSelectIndex,
  });
  // :
  //  _child = child,
  //      _currentIndex = currentIndex,
  //      _onSelectIndex = onSelectIndex;

  // final Widget _child;
  // final int _currentIndex;
  // final void Function(int)? _onSelectIndex;

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
    routes: [
      FriendsRoute(),
      HealthyRoute(),
      AchievementsRoute(),
      ChatsRoute(),
      SettingsRoute(),
    ],
    builder: (context, child) {
      final tabsRouter = AutoTabsRouter.of(context);

      return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          type: BottomNavigationBarType.fixed,
          onTap: tabsRouter.setActiveIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'FRIENDS'),
            BottomNavigationBarItem(
              icon: Icon(Icons.h_plus_mobiledata_outlined),
              label: 'HEALTHY',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_outlined),
              label: 'ACHIEVEMENTS',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'CHATS'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'SETTINGS',
            ),
          ],
        ),
      );
    },
  );
}
