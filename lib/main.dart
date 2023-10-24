import 'package:apod_flutter/today_apod.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Today's Picture"),
        ),
        body: const Center(child: TodayApod()),
      ),
    );
  }
}
