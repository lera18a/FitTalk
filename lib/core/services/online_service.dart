import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnlineService {
  static final OnlineService _instance = OnlineService._internal();
  factory OnlineService() => _instance;
  OnlineService._internal();

  final _client = Supabase.instance.client;
  Timer? _heartbeatTimer;
  StreamSubscription<AuthState>? _authSubscription;
  bool _isInitialized = false;

  static const _heartbeatDuration = Duration(seconds: 30);

  static void initialize() {
    _instance._initializeInternal();
  }

  void _initializeInternal() {
    if (_isInitialized) return;
    _isInitialized = true;

    debugPrint('🟢 OnlineService инициализирован');

    // 1. Слушаем изменения авторизации (вход/выход/восстановление сессии)
    _authSubscription = _client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.initialSession) {
        _startHeartbeat();
      } else if (event == AuthChangeEvent.signedOut) {
        _stopHeartbeat();
      }
    });

    // 2. Если пользователь уже авторизован при старте — запускаем сразу
    if (_client.auth.currentUser != null) {
      _startHeartbeat();
    }
  }

  void _startHeartbeat() {
    _stopHeartbeat(); // Отменяем старый таймер если был
    debugPrint('▶️ Запуск Heartbeat для user: ${_client.auth.currentUser?.id}');

    _updateLastSeen(); // Сразу один раз
    _heartbeatTimer = Timer.periodic(
      _heartbeatDuration,
      (_) => _updateLastSeen(),
    );
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    debugPrint('⏹️ Heartbeat остановлен');
  }

  Future<void> _updateLastSeen() async {
    try {
      final session = _client.auth.currentSession;
      if (session == null) {
        debugPrint('⚠️ Нет активной сессии, пропуск heartbeat');
        return;
      }

      final response = await _client.rpc('update_last_seen');
      debugPrint('❤️ Heartbeat успешно! Новое время в БД: $response');
    } catch (e) {
      debugPrint('💔 Heartbeat ошибка: $e');
    }
  }

  void dispose() {
    _stopHeartbeat();
    _authSubscription?.cancel();
    _isInitialized = false;
  }
}
