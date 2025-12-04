import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/settings_page.dart';
import '../../lib/app_config.dart';


void main() {
  setUp(() {
    // reset config before each test
    AppConfig.darkMode = false;
    AppConfig.fontSize = 16;
  });

  testWidgets('Settings page shows basic sections', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsPage(),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('Toggling dark mode updates AppConfig', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsPage(),
      ),
    );

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    final before = AppConfig.darkMode;

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    // value should flip
    expect(AppConfig.darkMode, isNot(before));
  });

  testWidgets('Moving font size slider changes AppConfig.fontSize',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final sliderFinder = find.byType(Slider);
        expect(sliderFinder, findsOneWidget);

        final slider = tester.widget<Slider>(sliderFinder);
        final oldValue = slider.value;

        await tester.drag(sliderFinder, const Offset(50, 0));
        await tester.pump();

        expect(AppConfig.fontSize != oldValue, true);
      });
}
