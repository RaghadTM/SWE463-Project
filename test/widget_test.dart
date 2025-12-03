import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:untitled25/main.dart';
import 'package:untitled25/home_page.dart';

void main() {
  testWidgets('Home page shows Prayer+ and Quran 1:7', (WidgetTester tester) async {
    await tester.pumpWidget(const PrayerApp());


    expect(find.text('Prayer+'), findsOneWidget);
    expect(find.text('Quran 1:7'), findsOneWidget);
  });
}
