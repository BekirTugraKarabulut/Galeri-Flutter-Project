import 'dart:convert';

import 'package:http/http.dart' as http;

class ArabaEkleService {

      Future<bool> arabaEkle(String marka, String model , int yil , String fiyat , String aracResmi , String galericiId) async {

        final url = Uri.parse("http://10.0.2.2:8086/arac-ekle");

        final response = await http.post(

          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'marka': marka,
            'model': model,
            'yil': yil,
            'fiyat': fiyat,
            'aracResmi': aracResmi,
            "galerici" :
            {
              "galericiId": galericiId
            }
          }
        ),
        );

        if(response.statusCode == 200){
          return true;
        } else {
          return false;
        }
      }
}