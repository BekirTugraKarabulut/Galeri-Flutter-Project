import 'dart:convert';

import 'package:http/http.dart' as http;

class KullaniciFavoriEkleService {

   Future<bool> favoriEkle(String username , int aracId) async {
     
     final url = Uri.parse("http://10.0.2.2:8086/favorileme/favorilemeEkle");

     final response = await http.post(

       url,
       headers: {"Content-Type": "application/json" },
       body: jsonEncode(
         {
           "kullanici" :
               {
                 "username": username
               },
           "arac" :
                {
                  "aracId": aracId
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