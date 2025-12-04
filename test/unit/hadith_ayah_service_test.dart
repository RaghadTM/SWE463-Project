import 'package:flutter_test/flutter_test.dart';
import '../../lib/services/hadith_ayah_service.dart';

void main() {
  final service = HadithAyahService();

  test('fetchRandomAyah returns basic fields', () async {
    final result = await service.fetchRandomAyah();

    expect(result['text'], isNotNull);
    expect((result['text'] as String).isNotEmpty, true);
    expect(result['source'], isNotNull);
    expect(result['type'], 'ayah');
  });

  test('fetchRandomHadith returns basic fields', () async {
    final result = await service.fetchRandomHadith();

    expect(result['text'], isNotNull);
    expect((result['text'] as String).isNotEmpty, true);
    expect(result['source'], isNotNull);
    expect(result['type'], 'hadith');
  });

  test('fetchRandomContent returns ayah or hadith', () async {
    final result = await service.fetchRandomContent();

    expect(result['text'], isNotNull);
    expect(result['source'], isNotNull);
    expect(result['type'] == 'ayah' || result['type'] == 'hadith', true);
  });
}
