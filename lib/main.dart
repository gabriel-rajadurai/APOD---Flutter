import 'package:apod_flutter/screens/today_apod/today_apod_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          background: Color(0xff0d0f1e),
        )),
      home: const Scaffold(
        body: TodayApodPage(),
      ),
    );
  }
}
