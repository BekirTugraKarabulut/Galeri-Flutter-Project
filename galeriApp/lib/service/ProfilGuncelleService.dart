import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfilGuncelleService {

  Future<bool> updateKullaniciBilgileri(String username, String isim, String soyisim, String telefonNo) async {

    final url = Uri.parse("http://10.0.2.2:8086/kullanici/update/$username");
    final response = await http.put(

        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {
              "username": username,
              "isim": isim,
              "soyisim": soyisim,
              "telefonNo": telefonNo
            }
        )
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  }
}