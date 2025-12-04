import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'prayer_times_page.dart';
import 'submit_hadith_page.dart';
import 'settings_page.dart';
import 'app_config.dart';
import 'services/hadith_ayah_service.dart';

class PrayerHomePage extends StatefulWidget {
  final String submittedCategory;
  final String submittedText;

  const PrayerHomePage({
    super.key,
    this.submittedCategory = '',
    this.submittedText = '',
  });

  @override
  State<PrayerHomePage> createState() => _PrayerHomePageState();
}

class _PrayerHomePageState extends State<PrayerHomePage> {
  final _service = HadithAyahService();

  String? _apiText;
  String? _apiSource;
  bool _isLoadingApi = true;
  String? _apiError;

  // list of user notes from Firestore
  List<Map<String, dynamic>> _userNotes = [];
  bool _isLoadingNotes = true;

  @override
  void initState() {
    super.initState();
    // load API content and user notes when home screen opens
    _loadApiContent();
    _loadUserNotes();
  }

  // load random ayah or hadith from service
  Future<void> _loadApiContent() async {
    setState(() {
      _isLoadingApi = true;
      _apiError = null;
    });

    try {
      final data = await _service.fetchRandomContent();
      if (!mounted) return;

      setState(() {
        _apiText = data['text'];
        _apiSource = data['source'];
        _isLoadingApi = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _apiError = 'Failed to load content';
        _isLoadingApi = false;
      });
    }
  }

  // load all user requests from "hadith_submissions" collection
  Future<void> _loadUserNotes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('hadith_submissions')
          .orderBy('createdAt', descending: true)
          .get();

      if (!mounted) return;

      final notes = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'text': data['text'] ?? '',
          'category': data['category'] ?? '',
          'createdAt': data['createdAt'],
        };
      }).toList();

      setState(() {
        _userNotes = notes;
        _isLoadingNotes = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _userNotes = [];
        _isLoadingNotes = false;
      });
    }
  }

  // handle bottom navigation clicks
  void _onNavTap(BuildContext context, int index) {
    if (index == 0) {

    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PrayerTimesPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SubmitHadithPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SettingsPage()),
      );
    }
  }

  // share current content using share_plus
  void _onShare(String title, String body) {
    final trimmed = body.trim();
    if (trimmed.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No content to share yet')),
      );
      return;
    }

    final message = '$title:\n$trimmed\n\nShared from Prayer+';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
    AppConfig.darkMode ? const Color(0xFF111827) : const Color(0xFFF5F7FB);
    final cardColor =
    AppConfig.darkMode ? const Color(0xFF1F2933) : Colors.white;
    final mainTextColor =
    AppConfig.darkMode ? Colors.white : Colors.black87;
    final subtitleColor =
    AppConfig.darkMode ? Colors.grey[300] : Colors.grey[600];

    // prepare API text to show on UI
    String displayTitle = 'Ayah / Hadith of the Day';
    String displayBody = '';
    String displayRef = '';

    if (_isLoadingApi) {
      displayBody = 'Loading...';
    } else if (_apiError != null) {
      displayBody = _apiError!;
    } else {
      displayBody = _apiText ?? '';
      displayRef = _apiSource ?? '';
    }


    final double bodyFontSize =
    displayBody.length > 400 ? AppConfig.fontSize - 2 : AppConfig.fontSize;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) => _onNavTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined, size: 10),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Home Screen',
                      style: TextStyle(
                        fontSize: AppConfig.fontSize - 4,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Prayer+',
                        style: TextStyle(
                          fontSize: AppConfig.fontSize + 4,
                          fontWeight: FontWeight.w700,
                          color: mainTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),


                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),

                            // API section
                            Text(
                              displayTitle,
                              style: TextStyle(
                                fontSize: AppConfig.fontSize,
                                fontWeight: FontWeight.w600,
                                color: mainTextColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              displayBody,
                              style: TextStyle(
                                fontSize: bodyFontSize,
                                color: mainTextColor,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            if (displayRef.isNotEmpty)
                              Text(
                                displayRef,
                                style: TextStyle(
                                  fontSize: AppConfig.fontSize - 2,
                                  color: subtitleColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  _onShare(displayTitle, displayBody),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF111827),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Text(
                                'Share',
                                style: TextStyle(
                                  fontSize: AppConfig.fontSize - 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            //user saved notes section
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Your Saved Notes',
                                style: TextStyle(
                                  fontSize: AppConfig.fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: mainTextColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            if (_isLoadingNotes)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            else if (_userNotes.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0),
                                child: Text(
                                  'No notes submitted yet.',
                                  style: TextStyle(
                                    fontSize: AppConfig.fontSize - 2,
                                    color: subtitleColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _userNotes.length,
                                separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final note = _userNotes[index];
                                  final category =
                                  (note['category'] ?? '').toString();
                                  final text =
                                  (note['text'] ?? '').toString();

                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppConfig.darkMode
                                          ? const Color(0xFF111827)
                                          : const Color(0xFFF5F5F5),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.isEmpty
                                              ? 'Note'
                                              : category,
                                          style: TextStyle(
                                            fontSize: AppConfig.fontSize - 2,
                                            fontWeight: FontWeight.w600,
                                            color: mainTextColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          text,
                                          style: TextStyle(
                                            fontSize: AppConfig.fontSize - 2,
                                            color: mainTextColor,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
