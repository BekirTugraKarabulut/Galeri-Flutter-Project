import 'package:flutter/material.dart';
import 'package:galeri_app/pages/Anasayfa.dart';
import 'package:galeri_app/service/LoginService.dart';
import 'package:lottie/lottie.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final LoginService _loginService = LoginService();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      suffixIcon: Icon(icon, color: Colors.black),
      filled: true,
      fillColor: Colors.orange,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  final TextStyle _textStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Lottie.asset("assets/auth.json", width: 280, height: 280,),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: usernameController,
                  style: _textStyle,
                  decoration: _inputDecoration("Kullanıcı Adı", Icons.person,),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: _textStyle,
                  decoration: _inputDecoration("Şifre", Icons.lock,),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {

                      if(usernameController.text.isEmpty || passwordController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text("Lütfen tüm alanları doldurun !"),
                          action: SnackBarAction(label: "Tamam", onPressed: (){}),
                          )
                        );
                        return;
                      }

                      bool response = await _loginService.login(usernameController.text, passwordController.text);

                      if(response){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Giriş Başarılı"),
                          action: SnackBarAction(label: "Tamam", onPressed: (){}),)
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Anasayfa(username: usernameController.text)));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Giriş Bilgileri Hatalı !"),
                          action: SnackBarAction(label: "Tamam", onPressed: (){}),
                          )
                        );
                        return;
                      }

                  },
                  child: const Text("Giriş Yap", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabın Yok Mu ?" , style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, "/registerpage"),
                        child: Text("Kayıt Ol" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
