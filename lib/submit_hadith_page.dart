import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void dispose() {
    _hadithController.dispose();
    super.dispose();
  }

  // handle submit button: validate, save to Firestore, then go back home
  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final text = _hadithController.text.trim();
    final category = _selectedCategory;

    try {
      // save new submission in a Firestore collection
      await FirebaseFirestore.instance
          .collection('hadith_submissions')
          .add({
        'text': text,
        'category': category,
        'createdAt': FieldValue.serverTimestamp(),
      });


      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PrayerHomePage(
            submittedCategory: category,
            submittedText: text,
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit: $e')),
      );
    }
  }

  // bottom navigation
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
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.circle_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ''),
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
                          'Submit',
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
                        'Submit Hadith or Note',
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

                      // category dropdown
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

                      // submit button
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
