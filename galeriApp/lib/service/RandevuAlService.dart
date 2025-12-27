import 'dart:convert';

import 'package:http/http.dart' as http;

class RandevuAllService{

    Future<bool> randevuAl(String username , String randevuTarihi , String randevuSaati , String galericiId) async {

      final url = Uri.parse("http://10.0.2.2:8086/randevu/randevuAl");

      final response = await http.post(

        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "randevuTarihi" : randevuTarihi,
            "randevuSaati" : randevuSaati,
            "kullanici" :
                {
                  "username" : username
                },
            "galerici" :
                {
                  "galericiId" : galericiId
                }
          }

        )
      );

      if(response.statusCode == 200){
        return true;
      } else {
        return false;
      }
    }

}