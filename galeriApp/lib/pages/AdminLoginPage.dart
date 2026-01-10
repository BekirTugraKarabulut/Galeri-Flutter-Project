import 'package:flutter/material.dart';
import 'package:galeri_app/pages/AdminPage.dart';
import 'package:galeri_app/service/AdminLoginService.dart';
import 'package:lottie/lottie.dart';

class Adminloginpage extends StatefulWidget {
  const Adminloginpage({super.key});

  @override
  State<Adminloginpage> createState() => _AdminloginpageState();
}

class _AdminloginpageState extends State<Adminloginpage> {

  AdminLoginService _adminLoginService = new AdminLoginService();

  final galericiId = TextEditingController();
  final password = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.orange,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Lottie.asset("assets/admin.json", width: 280, height: 280,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 15 , left: 15),
                child: TextField(
                  controller: galericiId,
                  style: _textStyle,
                  decoration: _inputDecoration("Galeri ID", Icons.badge,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 15 , left: 15),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  style: _textStyle,
                  decoration: _inputDecoration("Şifre", Icons.lock,
                  ),
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
                  onPressed: ()  async {

                    bool response = await _adminLoginService.loginAdmin(galericiId.text, password.text);

                    if(galericiId.text.isEmpty || password.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: Colors.orange,content: Text("Lütfen Tüm Alanları Doldurun",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),
                        )
                      );
                      return;
                    }

                    if(response){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: Colors.orange,content: Text("Giriş Başarılı",style: TextStyle(color:  Colors.black , fontWeight: FontWeight.bold),))
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Arabaeklepage(galericiId: galericiId.text)));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: Colors.orange,content: Text("Giriş Başarısız",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                        action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),
                        )
                      );
                      return;
                    }
                  },
                  child: const Text("Admin Giriş", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
