import 'dart:convert';

import 'package:http/http.dart' as http;

class AdminRandevularService {

  Future<List<Map<String , dynamic>>> tumRandevuListesi () async {
    
    final url = Uri.parse("http://10.0.2.2:8086/randevu/getAllRandevular");

    final response = await http.get(

      url,
      headers: {
        "Content-Type" : "application/json"
      }

    );
    
    if(response.statusCode == 200) {

      List<dynamic> jsonList = jsonDecode(response.body);
      List<Map<String , dynamic>> randevuListesi = List<Map<String , dynamic>>.from(jsonList);
      return randevuListesi;

    } else {
      throw Exception("Randevu listesi alınamadı");
    }
  }
  
}