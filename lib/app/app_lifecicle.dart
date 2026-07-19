import 'dart:async';
import 'package:flutter/material.dart';

final class AppLifecicle extends StatefulWidget {
  const AppLifecicle({super.key});

  @override
  State<AppLifecicle> createState() => _AppLifecicleState();
}

class _AppLifecicleState extends State<AppLifecicle>
    with WidgetsBindingObserver {
  Timer? _offlineTimer;

  @override
  void initState() async {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _offlineTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  Widget build(BuildContext context) {
    return context.widget;
  }
}
