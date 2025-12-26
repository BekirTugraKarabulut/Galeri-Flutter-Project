import 'dart:convert';
import 'package:http/http.dart' as http;

class AracGetAllService {

  Future<List<Map<String, dynamic>>> getAllArac() async {

    final url = Uri.parse("http://10.0.2.2:8086/araclar");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {

      final List<dynamic> aracList = jsonDecode(response.body);

      return aracList
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } else {
      throw Exception("Failed to load araclar");
    }
  }
}
