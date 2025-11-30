import 'package:flutter/material.dart';
import 'home_page.dart';
import 'submit_hadith_page.dart';
import 'settings_page.dart';
import 'app_config.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PrayerHomePage()),
      );
    } else if (index == 1) {

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
    final prayerTimes = [
      {'name': 'Fajr', 'time': '5:00 AM'},
      {'name': 'Dhuhr', 'time': '12:30 PM'},
      {'name': 'Asr', 'time': '3:45 PM'},
      {'name': 'Maghrib', 'time': '6:15 PM'},
      {'name': 'Isha', 'time': '8:00 PM'},
    ];

    final bgColor =
    AppConfig.darkMode ? const Color(0xFF111827) : const Color(0xFFF5F7FB);
    final cardColor =
    AppConfig.darkMode ? const Color(0xFF1F2933) : Colors.white;
    final textColor =
    AppConfig.darkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index) => _onNavTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle, size: 10),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Prayer Times',
                        style: TextStyle(
                          fontSize: AppConfig.fontSize - 4,
                          color: AppConfig.darkMode
                              ? Colors.grey[300]
                              : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prayer+',
                          style: TextStyle(
                            fontSize: AppConfig.fontSize + 4,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // TODO: استدعاء API لاحقاً
                          },
                          child: Text(
                            'Refresh',
                            style: TextStyle(
                              fontSize: AppConfig.fontSize - 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.separated(
                        itemCount: prayerTimes.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = prayerTimes[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name']!,
                                    style: TextStyle(
                                      fontSize: AppConfig.fontSize,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['time']!,
                                    style: TextStyle(
                                      fontSize: AppConfig.fontSize - 4,
                                      color: AppConfig.darkMode
                                          ? Colors.grey[300]
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.circle,
                                  size: 10,
                                ),
                              ),
                            ],
                          );
                        },
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
