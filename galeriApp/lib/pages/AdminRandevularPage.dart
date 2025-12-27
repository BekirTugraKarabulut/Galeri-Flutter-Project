import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:galeri_app/service/AdminRandevularService.dart';

class Adminrandevularpage extends StatefulWidget {

  String galericiId;
  Adminrandevularpage({super.key , required this.galericiId});

  @override
  State<Adminrandevularpage> createState() => _AdminrandevularpageState();
}

class _AdminrandevularpageState extends State<Adminrandevularpage> {

  AdminRandevularService adminRandevularService = AdminRandevularService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new , color: Colors.orange,)),
        title: Text("Randevular" , style: TextStyle(color: Colors.orange),),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: adminRandevularService.tumRandevuListesi(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var randevularListesi = snapshot.data!;
                      return ListView.builder(
                          itemCount: randevularListesi.length,
                          itemBuilder: (context, index) {
                            var randevu = randevularListesi[index];
                            DateTime tarih = DateTime.parse(randevu["randevuTarihi"]);
                            String duzenliTarih = DateFormat("yyyy-MM-dd").format(tarih);
                            return Container(
                              height: 80,
                              child: Card(color: Colors.orange,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Müşteri Adı : " + randevu["kullanici"]["isim"] + " " + randevu["kullanici"]["soyisim"] , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Randevu Tarihi : " + duzenliTarih + " "),
                                        Icon(Icons.date_range , size: 18, color: Colors.black,)
                                      ],
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Randevu Saati : " + randevu["randevuSaati"] + " "),
                                        Icon(Icons.timelapse_outlined , size: 18, color: Colors.black,)
                                      ],
                                    ),
                                  ],
                                )
                              ),
                            );
                          },
                      );
                    }
                    else{
                      return Text("Randevu yok ");
                    }
                  },
              ),
            )
          ],
        ),
      ),
    );
  }
}
