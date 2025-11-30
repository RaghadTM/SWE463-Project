import 'package:flutter/material.dart';
import 'home_page.dart';
import 'prayer_times_page.dart';
import 'submit_hadith_page.dart';
import 'app_config.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = AppConfig.darkMode;
  double fontSize = AppConfig.fontSize;
  bool prayerAlerts = false;
  bool hadithAlerts = false;

  Color get _bgColor =>
      darkMode ? const Color(0xFF111827) : const Color(0xFFF5F7FB);
  Color get _cardColor =>
      darkMode ? const Color(0xFF1F2933) : Colors.white;
  Color get _textColor =>
      darkMode ? Colors.white : Colors.black87;

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PrayerHomePage()),
      );
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
      // هنا أصلًا
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        onTap: _onNavTap,
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
              color: _cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 6,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: fontSize - 4,
                            color: Colors.grey[400],
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
                              fontSize: fontSize + 4,
                              fontWeight: FontWeight.w700,
                              color: _textColor,
                            ),
                          ),
                          Icon(
                            Icons.settings_outlined,
                            color: _textColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Appearance',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: _textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontSize: fontSize,
                              color: _textColor,
                            ),
                          ),
                          Switch(
                            value: darkMode,
                            onChanged: (v) {
                              setState(() {
                                darkMode = v;
                                AppConfig.darkMode = v;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Font Size',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: _textColor,
                        ),
                      ),
                      Slider(
                        value: fontSize,
                        min: 12,
                        max: 24,
                        onChanged: (v) {
                          setState(() {
                            fontSize = v;
                            AppConfig.fontSize = v;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: _textColor,
                        ),
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        title: Text(
                          'Prayer Time Alerts',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: _textColor,
                          ),
                        ),
                        value: prayerAlerts,
                        onChanged: (v) {
                          setState(() => prayerAlerts = v ?? false);
                        },
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        title: Text(
                          'Daily Hadith Notifications',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: _textColor,
                          ),
                        ),
                        value: hadithAlerts,
                        onChanged: (v) {
                          setState(() => hadithAlerts = v ?? false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
