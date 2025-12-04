import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class PrayerTimeService {

  // 🔥 جلب أوقات الصلاة حسب موقع المستخدم فقط
  Future<Map<String, dynamic>> fetchPrayerTimesByLocation() async {
    final location = Location();

    // 1) التأكد أن خدمة الموقع مفعّلة
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location service is disabled");
      }
    }

    // 2) طلب إذن الوصول للموقع
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception("Location permission denied");
      }
    }

    // 3) جلب الإحداثيات (latitude / longitude)
    final userLocation = await location.getLocation();

    final url = Uri.parse(
        "https://api.aladhan.com/v1/timings"
            "?latitude=${userLocation.latitude}"
            "&longitude=${userLocation.longitude}"
            "&method=2" // طريقة الحساب، 2 = جامعة أم القرى
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch prayer times");
    }

    final data = jsonDecode(response.body);

    return data["data"]["timings"];
  }
}