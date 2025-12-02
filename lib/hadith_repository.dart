class HadithEntry {
  final String text;
  final String category;
  final DateTime createdAt;

  HadithEntry({
    required this.text,
    required this.category,
    required this.createdAt,
  });
}

class HadithRepository {
  static final List<HadithEntry> _entries = [];

  static void addHadith(String text, String category) {
    _entries.add(
      HadithEntry(
        text: text,
        category: category,
        createdAt: DateTime.now(),
      ),
    );
  }

  static List<HadithEntry> get entries => List.unmodifiable(_entries);

  static HadithEntry? get latest =>
      _entries.isNotEmpty ? _entries.last : null;
}
