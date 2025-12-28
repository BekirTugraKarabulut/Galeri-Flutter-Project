import 'dart:convert';

import 'package:http/http.dart' as http;

class KullaniciFavorilerimService {

      Future<List<Map<String , dynamic>>> favorilerim(String username) async {
        
          final url = Uri.parse("http://10.0.2.2:8086/favorileme/kullaniciFavoriListByUsername/$username");

          final response = await http.get(

            url,
            headers: {
              "Content-Type" : "application/json"
            }

          );

          if(response.statusCode == 200){
            List<dynamic> jsonData = jsonDecode(response.body);
            List<Map<String , dynamic>> favorilerimList = List<Map<String , dynamic>>.from(jsonData);
            return favorilerimList;
          } else {
            throw Exception("Favorilerim listesi alınamadı");
        }
      }

}