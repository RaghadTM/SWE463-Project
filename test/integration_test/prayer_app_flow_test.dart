import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../../lib/settings_page.dart';
import '../../lib/app_config.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('settings flow works', (WidgetTester tester) async {
    AppConfig.darkMode = false;
    AppConfig.fontSize = 16;

    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsPage(),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);

    final switchFinder = find.byType(Switch);
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    final sliderFinder = find.byType(Slider);
    await tester.drag(sliderFinder, const Offset(40, 0));
    await tester.pump();
  });
}
