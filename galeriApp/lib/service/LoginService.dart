import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService{

    Future<bool> login(String username , String password) async {
      
      final url = Uri.parse("http://10.0.2.2:8086/login");

      final response = await http.post(

        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password
        })
      );

      if(response.statusCode == 200){
          final data = jsonDecode(response.body);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("accessToken", data["accessToken"]);
          await prefs.setString("refreshToken", data["refreshToken"]);
          return true;
      }
      else if(response.statusCode == 401){
        return false;
      }
      else{
        return false;
      }

    }

}