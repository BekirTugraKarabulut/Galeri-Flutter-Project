import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminKullanicilarimService {

  Future<List<Map<String, dynamic>>> allKullanicilar() async {

    final url = Uri.parse("http://10.0.2.2:8086/admin/kullanicilar");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {

      if (response.body.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(jsonList);

    } else {
      throw Exception("Kullanıcılar alınamadı");
    }
  }
}
