import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class PrayerTimeService {

  // get prayer times using user's current GPS location
  Future<Map<String, dynamic>> fetchPrayerTimesByLocation() async {
    final location = Location();

    // check if location service is turned on
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location service is disabled");
      }
    }

    // ask for location permission
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception("Location permission denied");
      }
    }

    // get user latitude and longitude
    final userLocation = await location.getLocation();

    final url = Uri.parse(
        "https://api.aladhan.com/v1/timings"
            "?latitude=${userLocation.latitude}"
            "&longitude=${userLocation.longitude}"
            "&method=2"
    );

    final response = await http.get(url);


    if (response.statusCode != 200) {
      throw Exception("Failed to fetch prayer times");
    }

    final data = jsonDecode(response.body);


    return data["data"]["timings"];
  }
}
