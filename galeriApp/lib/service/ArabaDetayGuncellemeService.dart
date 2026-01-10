import 'dart:convert';

import 'package:http/http.dart' as http;

class ArabaDetayGuncellemeService {
  
    Future<bool> guncelleArabaDetay(int aracId , String marka , String model , int yil , String fiyat) async {
      
      final url = Uri.parse("http://10.0.2.2:8086/arac-guncelle/$aracId");

      final response = await http.put(

        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
            "marka" : marka,
            "model" : model,
             "yil" : yil,
             "fiyat" : fiyat,
        })
      );

      if(response.statusCode == 200){
        return true;
      } else {
        return false;
      }

    }
  
}