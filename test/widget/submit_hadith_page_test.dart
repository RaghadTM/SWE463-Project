import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/submit_hadith_page.dart';
import '../../lib/app_config.dart';

void main() {
  setUp(() {
    AppConfig.fontSize = 16;
    AppConfig.darkMode = false;
  });

  testWidgets('Submit page shows text field and dropdown', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SubmitHadithPage(),
      ),
    );

    expect(find.text('Submit Hadith or Note'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  });

  testWidgets('Text field validator returns error on empty input', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SubmitHadithPage(),
      ),
    );

    final field = tester.widget<TextFormField>(find.byType(TextFormField));
    final validator = field.validator;
    final result = validator?.call('');

    expect(result, 'Please enter a hadith or note');
  });

  testWidgets('Dropdown shows Note option when opened', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SubmitHadithPage(),
      ),
    );

    final dropdownFinder = find.byType(DropdownButtonFormField<String>);
    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();

    expect(find.text('Note'), findsWidgets);
  });
}
