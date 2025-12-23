import 'package:flutter/material.dart';
import 'package:galeri_app/model/Kullanici.dart';
import 'package:galeri_app/service/RegisterService.dart';
import 'package:lottie/lottie.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {

  late Kullanici kullanici;
  RegisterService _registerService = RegisterService();

  final usernameController = TextEditingController();
  final isimController = TextEditingController();
  final soyisimController = TextEditingController();
  final passwordController = TextEditingController();
  final telefonNoController = TextEditingController();

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
              Lottie.asset("assets/Login.json", width: 280, height: 280,),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: usernameController,
                  style: _textStyle,
                  decoration: _inputDecoration("Kullanıcı Adı", Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: isimController,
                  style: _textStyle,
                  decoration: _inputDecoration("İsim", Icons.badge),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: soyisimController,
                  style: _textStyle,
                  decoration: _inputDecoration("Soyisim", Icons.badge_outlined),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: telefonNoController,
                  keyboardType: TextInputType.phone,
                  style: _textStyle,
                  decoration: _inputDecoration("Telefon Numarası", Icons.phone),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: _textStyle,
                  decoration: _inputDecoration("Şifre", Icons.lock),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.orange
                ),
                shape: WidgetStatePropertyAll(
                 RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(10)
                 )
                )
              ),onPressed: (){
          
                  if(usernameController.text.isEmpty || isimController.text.isEmpty || soyisimController.text.isEmpty || passwordController.text.isEmpty || telefonNoController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Lütfen tüm alanları doldurun"),
                      action: SnackBarAction(label: "Tamam", onPressed: (){}),
                      )
                    );
                    return;
                  }
                      
                  _registerService.register(usernameController.text, isimController.text, soyisimController.text, passwordController.text, telefonNoController.text)
                      .then((value){
                        if(value != null){
                          kullanici = value;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Kayıt Başarılı ! Giriş Sayfasına Yönlendiriliyorsunuz..."),
                                action: SnackBarAction(label: "Tamam", onPressed: (){}),
                              )
                          );
                          Navigator.pushReplacementNamed(context, "/loginpage");
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Kayıt Başarısız Oldu ! Lütfen Tekrar Deneyin."),
                                action: SnackBarAction(label: "Tamam", onPressed: (){}),
                              )
                          );
                          return;
                        }
                  });
          
              }, child: Text("Kayıt Ol",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 15),)),
              const SizedBox(height: 15,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Zaten bir hesabım var ?",style: TextStyle(color: Colors.white ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, "/loginpage"),
                        child: Text("Giriş Yap" , style: TextStyle(decoration: TextDecoration.underline,color: Colors.white , fontWeight: FontWeight.bold),)),
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
