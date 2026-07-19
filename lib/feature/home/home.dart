import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required Widget child,
    int currentIndex = 0,
    void Function(int)? onSelectIndex,
  }) : _child = child,
       _currentIndex = currentIndex,
       _onSelectIndex = onSelectIndex;

  final Widget _child;
  final int _currentIndex;
  final void Function(int)? _onSelectIndex;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _child,
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onSelectIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'CHATS'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'SETTINGS'),
      ],
    ),
  );
}
