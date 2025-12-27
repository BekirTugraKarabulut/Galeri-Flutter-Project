import 'package:flutter/material.dart';
import 'package:galeri_app/pages/AdminArabaEklePage.dart';
import 'package:galeri_app/pages/AdminAraclarimPage.dart';
import 'package:galeri_app/pages/AdminRandevularPage.dart';
import 'package:galeri_app/pages/ButtonPage.dart';

class Arabaeklepage extends StatefulWidget {

  String galericiId;
  Arabaeklepage({super.key , required this.galericiId});

  @override
  State<Arabaeklepage> createState() => _ArabaeklepageState();
}

class _ArabaeklepageState extends State<Arabaeklepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.add , color: Colors.black,),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Buttonpage()));
          }, icon: Icon(Icons.login_outlined , color: Colors.red,))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text("Admin Paneli" , style: TextStyle(color: Colors.orange , fontSize: 25 , fontWeight:  FontWeight.bold),),
            SizedBox(height: 200,),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.orange
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                )
              ),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Adminaraclarimpage()));
              }, child: Text("Araçlarım",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton(style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Colors.orange
                    ),
                    shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    )
                ),onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Adminarabaeklepage(galericiId: widget.galericiId)));
                }, child: Text("Araba Ekle",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton(style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Colors.orange
                    ),
                    shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    )
                ),onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Adminrandevularpage(galericiId: widget.galericiId)));
                }, child: Text("Randevular",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
