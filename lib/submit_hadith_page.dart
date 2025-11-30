import 'package:flutter/material.dart';
import 'home_page.dart';
import 'prayer_times_page.dart';
import 'settings_page.dart';
import 'app_config.dart';

class SubmitHadithPage extends StatefulWidget {
  const SubmitHadithPage({super.key});

  @override
  State<SubmitHadithPage> createState() => _SubmitHadithPageState();
}

class _SubmitHadithPageState extends State<SubmitHadithPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hadithController = TextEditingController();
  String _selectedCategory = 'Hadith';

  bool prayerAlerts = false;
  bool hadithAlerts = false;

  @override
  void dispose() {
    _hadithController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted successfully')),
      );
      _hadithController.clear();
      setState(() {
        _selectedCategory = 'Hadith';
      });
    }
  }

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
    final textColor =
    AppConfig.darkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Submit Hadith',
                          style: TextStyle(
                            fontSize: AppConfig.fontSize - 4,
                            color: AppConfig.darkMode
                                ? Colors.grey[300]
                                : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Prayer+',
                        style: TextStyle(
                          fontSize: AppConfig.fontSize + 4,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Submit Hadith',
                        style: TextStyle(
                          fontSize: AppConfig.fontSize,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _hadithController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Your Hadith or Note',
                          hintStyle: TextStyle(
                            fontSize: AppConfig.fontSize - 2,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: AppConfig.darkMode
                              ? const Color(0xFF111827)
                              : Colors.white,
                        ),
                        style: TextStyle(
                          fontSize: AppConfig.fontSize,
                          color: textColor,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a hadith or note';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: AppConfig.fontSize,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: AppConfig.darkMode
                              ? const Color(0xFF111827)
                              : Colors.white,
                        ),
                        dropdownColor: AppConfig.darkMode
                            ? const Color(0xFF111827)
                            : Colors.white,
                        items: const [
                          DropdownMenuItem(
                            value: 'Hadith',
                            child: Text('Hadith'),
                          ),
                          DropdownMenuItem(
                            value: 'Ayah',
                            child: Text('Ayah'),
                          ),
                          DropdownMenuItem(
                            value: 'Note',
                            child: Text('Note'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSubmit,
                          style: ElevatedButton.styleFrom(
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: const Color(0xFF111827),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: AppConfig.fontSize - 2,
                              color: Colors.white,
                            ),
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
      ),
    );
  }
}
