import 'package:flutter_test/flutter_test.dart';
import 'package:untitled25/app_config.dart';

void main() {
  test('AppConfig default values are correct', () {
    expect(AppConfig.darkMode, false);
    expect(AppConfig.fontSize, 16);
  });
}
