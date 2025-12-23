import 'dart:convert';
import 'package:galeri_app/model/Kullanici.dart';
import 'package:http/http.dart' as http;

class RegisterService {

  Future<Kullanici?> register(String username, String isim, String soyisim, String password, String telefonNo) async {

    final url = Uri.parse("http://10.0.2.2:8086/register");

    final response = await http.post(

        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {
              "username": username,
              "isim": isim,
              "soyisim": soyisim,
              "password": password,
              "telefonNo": telefonNo
            }
        )
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Kullanici(
          data['username'],
          data['isim'],
          data['soyisim'],
          data['password'],
          data['telefonNo']
      );
    } else {
      throw Exception("Kullanici kaydi basarisiz oldu !");
    }
  }

}