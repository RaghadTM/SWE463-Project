import 'package:flutter/material.dart';
import 'home_page.dart';
import 'submit_hadith_page.dart';
import 'settings_page.dart';
import 'app_config.dart';
import 'services/prayer_time_service.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final _service = PrayerTimeService();

  Map<String, dynamic>? prayerTimes;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _service.fetchPrayerTimes(
        city: "Riyadh",
        country: "Saudi Arabia",
      );

      setState(() {
        prayerTimes = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load prayer times";
        isLoading = false;
      });
    }
  }

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PrayerHomePage()),
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
    final textColor = AppConfig.darkMode ? Colors.white : Colors.black87;


    Widget content;

    if (isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      content = Center(
        child: Text(
          errorMessage!,
          style: TextStyle(color: textColor),
        ),
      );
    } else {
      final keys = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];
      final timesList = keys.map((k) => MapEntry(k, prayerTimes![k])).toList();


      content = ListView.separated(
        itemCount: timesList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = timesList[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.key,
                style: TextStyle(
                  fontSize: AppConfig.fontSize,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Text(
                item.value,
                style: TextStyle(
                  fontSize: AppConfig.fontSize - 4,
                  color: AppConfig.darkMode ? Colors.grey[300] : Colors.grey,
                ),
              ),
            ],
          );
        },
      );
    }

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Prayer Times',
                        style: TextStyle(
                          fontSize: AppConfig.fontSize - 4,
                          color:
                          AppConfig.darkMode ? Colors.grey[300] : Colors.grey,
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
                          onPressed: _loadPrayerTimes,
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


                    Expanded(child: content),
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