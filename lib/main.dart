import 'package:flutter/material.dart';
import 'home_page.dart';
import 'prayer_times_page.dart';
import 'settings_page.dart';


void main() {
  runApp(const PrayerApp());
}

class PrayerApp extends StatelessWidget {
  const PrayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prayer+',
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFF111827),
      ),
      home: const PrayerHomePage(),
    );
  }
}
