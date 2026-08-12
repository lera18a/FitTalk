import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class StatusRealtimeService {
  static final StatusRealtimeService _instance =
      StatusRealtimeService._internal();
  factory StatusRealtimeService() => _instance;
  StatusRealtimeService._internal();

  final _subscriptions = <String, StreamSubscription>{};

  // Подписка на статус пользователя
  StreamSubscription subscribeToUserStatus({
    required String userId,
    required void Function(DateTime? lastSeen) onStatusChanged,
  }) {
    // Отменяем предыдущую подписку если есть
    _subscriptions.remove(userId)?.cancel();

    final subscription = Supabase.instance.client
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .listen((profiles) {
          if (profiles.isEmpty) {
            onStatusChanged(null);
            return;
          }

          final lastSeenStr = profiles.first['last_seen'] as String?;
          final lastSeen = lastSeenStr != null
              ? DateTime.parse(lastSeenStr)
              : null;
          onStatusChanged(lastSeen);
        });

    _subscriptions[userId] = subscription;
    return subscription;
  }

  void dispose(String userId) {
    _subscriptions.remove(userId)?.cancel();
  }

  void disposeAll() {
    for (final sub in _subscriptions.values) {
      sub.cancel();
    }
    _subscriptions.clear();
  }
}
