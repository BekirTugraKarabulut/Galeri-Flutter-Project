import 'package:flutter/material.dart';

class Arabaeklepage extends StatefulWidget {
  const Arabaeklepage({super.key});

  @override
  State<Arabaeklepage> createState() => _ArabaeklepageState();
}

class _ArabaeklepageState extends State<Arabaeklepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Admin Paneli" , style: TextStyle(color: Colors.orange , fontSize: 25 , fontWeight:  FontWeight.bold),),
            SizedBox(height: 20,),
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

                }, child: Text("Araba Ekle",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
