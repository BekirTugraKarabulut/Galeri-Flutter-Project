import 'package:flutter/material.dart';

class Galerihakkindapage extends StatefulWidget {
  const Galerihakkindapage({super.key});

  @override
  State<Galerihakkindapage> createState() => _GalerihakkindapageState();
}

class _GalerihakkindapageState extends State<Galerihakkindapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Galerimiz Hakkında" , style: TextStyle(color: Colors.orange),),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("images/galeri.jpeg"),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10 , right: 10),
              child: Text("TuCar araç galerisi 2012 yılından beri sizlere hizmet vermektedir. Galerimiz motorsiklet ve araç satışı üzerine kurulmuş bir anonim şirketidir.",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: 15),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10 , right: 10),
              child: Text("TuCar ailesi, siz değerli müşterilerimizi ağırlamaktan memnuniyet duyar.",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: 15),),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home,color: Colors.white,),
                Text(" Atatürk Mahallesi Gül Sokak No:2 Beşiktaş/İstanbul",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)
              ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_box_rounded,color: Colors.white,),
                Text(" Bekir Tuğra KARABULUT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)
              ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone,color: Colors.white,),
                Text(" +90 0-542-316-48-58",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)
              ],
            ),
            SizedBox(height: 35,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star ,color: Colors.orange,),
                Text(" Bize Ulaşabilirsiniz",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
