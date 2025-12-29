import 'dart:convert';

import 'package:http/http.dart' as http;

class MarkaService{
  Future<List<Map<String , dynamic>>> markaGetAll(String marka) async {

    final url = Uri.parse("http://10.0.2.2:8086/marka/araclar/$marka");

    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
    });

    if(response.statusCode == 200){

      final List<dynamic> jsonList = jsonDecode(response.body);

      return List<Map<String , dynamic>>.from(jsonList);
    } else {
      throw Exception("Marka araçları getirilirken bir hata oluştu");
    }
  }
}
