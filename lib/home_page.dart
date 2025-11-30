// lib/home_page.dart
import 'package:flutter/material.dart';
import 'prayer_times_page.dart';
import 'submit_hadith_page.dart';
import 'settings_page.dart';
import 'app_config.dart';

class PrayerHomePage extends StatelessWidget {
  const PrayerHomePage({super.key});

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

    const ayahText =
        '"The path of those upon whom\n'
        'You have bestowed favor, not of\n'
        'those who have evoked [Your]\n'
        'anger or of those who are astray."';

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

                    // Prayer+ على اليسار
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
                    const SizedBox(height: 40),


                    Text(
                      ayahText,
                      style: TextStyle(
                        fontSize: AppConfig.fontSize,
                        color: mainTextColor,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),


                    Text(
                      'Quran 1:7',
                      style: TextStyle(
                        fontSize: AppConfig.fontSize - 2,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),


                    ElevatedButton(
                      onPressed: () {
                        // TODO: لاحقاً تشاركين الآية
                      },
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
