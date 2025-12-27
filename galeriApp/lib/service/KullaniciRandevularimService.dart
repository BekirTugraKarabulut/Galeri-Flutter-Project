import 'dart:convert';

import 'package:http/http.dart' as http;

class KullaniciRandevularimService {

    Future<List<Map<String , dynamic>>> randevularByUsername(String username) async {
      
        final url = Uri.parse("http://10.0.2.2:8086/randevu/getRandevularByUsername/$username");

        final response = await http.get(

          url,
          headers: {
            "Content-Type" : "application/json"
          }

        );

        if(response.statusCode == 200) {

          List<dynamic> jsonResponse = json.decode(response.body);
          List<Map<String , dynamic>> randevular = List<Map<String , dynamic>>.from(jsonResponse);
          return randevular;

        } else {
          throw Exception("Randevular alınamadı");
        }
      
    }

}