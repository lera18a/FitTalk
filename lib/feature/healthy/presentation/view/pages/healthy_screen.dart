import 'package:fit_talk/core/services/health_service.dart';
import 'package:flutter/material.dart';

class HealthyScreen extends StatefulWidget {
  const HealthyScreen({super.key});

  @override
  State<HealthyScreen> createState() => _HealthyScreenState();
}

class _HealthyScreenState extends State<HealthyScreen> {
  final _healthService = HealthService();
  Map<String, dynamic>? _stats;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final granted = await _healthService.requestPermissions();
    if (!granted) {
      setState(() => _loading = false);
      return;
    }

    final stats = await _healthService.getDailyStats();
    setState(() {
      _stats = stats;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_stats == null) {
      return const Center(child: Text('Нет доступа к данным здоровья'));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard('🚶', 'Шаги', '${_stats!['steps']}'),
          _buildCard('🔥', 'Калории', '${_stats!['calories']} kcal'),
          _buildCard('📏', 'Дистанция', '${_stats!['distance']} км'),
          if (_stats!['heartRate'] != null)
            _buildCard('❤️', 'Пульс', '${_stats!['heartRate']} уд/мин'),
          if (_stats!['weight'] != null)
            _buildCard('⚖️', 'Вес', '${_stats!['weight']} кг'),
        ],
      ),
    );
  }

  Widget _buildCard(String icon, String title, String value) {
    return Card(
      child: ListTile(
        leading: Text(icon, style: const TextStyle(fontSize: 28)),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
