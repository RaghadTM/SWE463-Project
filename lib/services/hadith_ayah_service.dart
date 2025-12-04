import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class HadithAyahService {

  // to get a random ayah from Quran API
  Future<Map<String, dynamic>> fetchRandomAyah() async {
    const totalAyat = 6236;
    final randomAyahNumber = 1 + Random().nextInt(totalAyat);

    final url = Uri.parse(
      "https://api.alquran.cloud/v1/ayah/$randomAyahNumber/en.asad",
    );

    final response = await http.get(url);

    // to make sure request was successful
    if (response.statusCode != 200) {
      throw Exception("Ayah error code: ${response.statusCode}");
    }

    final data = jsonDecode(response.body)["data"];

    return {
      "text": data["text"],
      "source": "${data["surah"]["englishName"]} • Ayah ${data["numberInSurah"]}",
      "type": "ayah"
    };
  }

  // to get a random hadith from Sahih Bukhari API
  Future<Map<String, dynamic>> fetchRandomHadith() async {
    final randomNumber = 1 + Random().nextInt(2000);

    final url = Uri.parse(
      "https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-bukhari/$randomNumber.min.json",
    );

    final response = await http.get(url);

    // check if API call failed
    if (response.statusCode != 200) {
      throw Exception("Hadith error code: ${response.statusCode}");
    }

    final data = jsonDecode(response.body);
    return {
      "text": data["hadiths"][0]["text"],
      "source": "Sahih Bukhari #$randomNumber",
      "type": "hadith"
    };
  }

  // to randomly return either ayah or hadith
  Future<Map<String, dynamic>> fetchRandomContent() async {
    final randomBool = Random().nextBool();
    if (randomBool) {
      return await fetchRandomAyah();
    } else {
      return await fetchRandomHadith();
    }
  }
}
