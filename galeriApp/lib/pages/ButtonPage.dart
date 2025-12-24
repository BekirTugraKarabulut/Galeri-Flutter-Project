import 'package:flutter/material.dart';
import 'package:galeri_app/pages/AdminLoginPage.dart';

class Buttonpage extends StatefulWidget {
  const Buttonpage({super.key});

  @override
  State<Buttonpage> createState() => _ButtonpageState();
}

class _ButtonpageState extends State<Buttonpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Adminloginpage()));
        }, icon: Icon(Icons.admin_panel_settings,color: Colors.orange,)),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Text("TuCar Galeri" , style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold , fontSize: 30),),
                  Text("Hoş Geldiniz" , style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold , fontSize: 25),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.orange
                        ),
                        shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),onPressed: (){
                        Navigator.pushReplacementNamed(context, "/registerpage");
                    }, child: Text("Kayıt Ol",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Container(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Colors.orange
                          ),
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          )
                      ),onPressed: (){
                        Navigator.pushReplacementNamed(context, "/loginpage");
                      }, child: Text("Giriş Yap",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
