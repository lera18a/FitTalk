import 'package:flutter/material.dart';

class OnlineStatusIndicator extends StatelessWidget {
  const OnlineStatusIndicator({
    super.key,
    required this.lastSeen,
    this.size = 12,
    this.showText = false,
  });

  final DateTime? lastSeen;
  final double size;
  final bool showText;

  bool get isOnline {
    if (lastSeen == null) return false;
    final diff = DateTime.now().difference(lastSeen!);
    return diff.inSeconds < 30; // Онлайн если был < 30 сек назад
  }

  @override
  Widget build(BuildContext context) {
    if (showText) {
      return Text(
        isOnline ? 'Онлайн' : _formatLastSeen(lastSeen),
        style: TextStyle(
          color: isOnline ? Colors.green : Colors.grey,
          fontSize: 12,
          fontWeight: isOnline ? FontWeight.bold : FontWeight.normal,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  String _formatLastSeen(DateTime? dt) {
    if (dt == null) return 'Был давно';
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Только что';
    if (diff.inHours < 1) return 'Был ${diff.inMinutes} мин. назад';
    if (diff.inDays < 1) return 'Был ${diff.inHours} ч. назад';
    return 'Был ${dt.day}.${dt.month}';
  }
}
