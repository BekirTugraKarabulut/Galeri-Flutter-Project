import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfilService{

    Future<Map<String,dynamic>> profilBilgileri(String username) async {

        final url = Uri.parse("http://10.0.2.2:8086/kullanici/get/$username");

        final response = await http.get(

          url,
          headers: {"Content-Type": "application/json"},

        );

        if(response.statusCode == 200){
          return jsonDecode(response.body);
        }
        else{
          throw Exception("Profil bilgileri alınamadı");
        }
    }

}