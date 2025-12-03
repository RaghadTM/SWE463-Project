import 'dart:convert';
import 'package:http/http.dart' as http;

class PrayerTimeService {

  Future<Map<String, dynamic>> fetchPrayerTimes({
    required String city,
    required String country,
  }) async {
    final url = Uri.parse(
      "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country",
    );

    final response = await http.get(url);


    if (response.statusCode != 200) {
      throw Exception("Failed to fetch prayer times");
    }

    final data = jsonDecode(response.body);
    print("API Returned timings: ${data["data"]["timings"]}");


    return data["data"]["timings"];
  }
}