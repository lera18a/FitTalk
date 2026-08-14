import 'package:health/health.dart';

class HealthService {
  final health = Health();

  final types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.WEIGHT,
    HealthDataType.DISTANCE_WALKING_RUNNING,
  ];
  Future<bool> requestPermissions() async {
    final permissions = types.map((e) => HealthDataAccess.READ).toList();

    bool? hasPermissions = await health.hasPermissions(
      types,
      permissions: permissions,
    );

    if (hasPermissions != true) {
      hasPermissions = await health.requestAuthorization(
        types,
        permissions: permissions,
      );
    }

    return hasPermissions ?? false;
  }

  Future<int> getStepsToday() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    final steps = await health.getTotalStepsInInterval(midnight, now);
    return steps ?? 0;
  }

  /// Получить пульс
  Future<double?> getLatestHeartRate() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(hours: 24));

    final data = await health.getHealthDataFromTypes(
      startTime: start,
      endTime: now,
      types: [HealthDataType.HEART_RATE],
    );

    if (data.isEmpty) return null;
    return data.last.value is NumericHealthValue
        ? (data.last.value as NumericHealthValue).numericValue.toDouble()
        : null;
  }

  /// Получить все данные за день
  Future<Map<String, dynamic>> getDailyStats() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    final data = await health.getHealthDataFromTypes(
      startTime: midnight,
      endTime: now,
      types: types,
    );

    // Убираем дубликаты
    final cleanData = Health().removeDuplicates(data);

    int steps = 0;
    double calories = 0;
    double distance = 0;
    double? heartRate;
    double? weight;

    for (final point in cleanData) {
      final value = point.value;
      if (value is NumericHealthValue) {
        final num = value.numericValue.toDouble();
        switch (point.type) {
          case HealthDataType.STEPS:
            steps += num.toInt();
            break;
          case HealthDataType.ACTIVE_ENERGY_BURNED:
            calories += num;
            break;
          case HealthDataType.DISTANCE_WALKING_RUNNING:
            distance += num;
            break;
          case HealthDataType.HEART_RATE:
            heartRate = num;
            break;
          case HealthDataType.WEIGHT:
            weight = num;
            break;
          default:
            break;
        }
      }
    }

    return {
      'steps': steps,
      'calories': calories.round(),
      'distance': (distance / 1000).toStringAsFixed(1), // км
      'heartRate': heartRate?.round(),
      'weight': weight,
    };
  }
}
