import 'dart:convert';

import 'package:http/http.dart' as http;

class AracDetayService {

  Future<Map<String , dynamic>> aracDetay(int aracId) async {

    final url = Uri.parse("http://10.0.2.2:8086/arac/$aracId");

    final response = await http.get(

      url,
      headers: {
        "Content-Type": "application/json",
      },

    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Araç detayı alınamadı");
    }

  }
}