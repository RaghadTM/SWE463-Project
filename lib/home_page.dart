import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _service.fetchRandomContent();
      setState(() {
        _apiText = data['text'];
        _apiSource = data['source'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load content';
        _isLoading = false;
      });
    }
  }

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

    final bool hasSubmitted = widget.submittedText.trim().isNotEmpty;

    String displayTitle = 'Ayah / Hadith of the Day';
    String displayBody = '';
    String displayRef = '';

    if (_isLoading) {
      displayBody = 'Loading...';
    } else if (_error != null) {
      displayBody = _error!;
    } else {
      final apiText = _apiText ?? '';
      final apiSource = _apiSource ?? '';

      if (hasSubmitted && apiText.isNotEmpty) {
        displayTitle = '${widget.submittedCategory} & Daily Reflection';
        displayBody = '${widget.submittedText.trim()}\n\n---\n\n$apiText';
        displayRef = apiSource;
      } else if (hasSubmitted) {
        displayTitle = widget.submittedCategory;
        displayBody = widget.submittedText.trim();
        displayRef = '';
      } else {
        displayTitle = 'Ayah / Hadith of the Day';
        displayBody = apiText;
        displayRef = apiSource;
      }
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
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                    const SizedBox(height: 24),


                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 24),
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
