import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:galeri_app/service/KullaniciRandevularimService.dart';

class Randevularimpage extends StatefulWidget {

  String username;

  Randevularimpage({super.key, required this.username});

  @override
  State<Randevularimpage> createState() => _RandevularimpageState();
}

class _RandevularimpageState extends State<Randevularimpage> {

  KullaniciRandevularimService kullaniciRandevularimService = KullaniciRandevularimService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.add , color: Colors.black,),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Randevularım",style: TextStyle(color: Colors.orange),),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String , dynamic>>>(
                  future: kullaniciRandevularimService.randevularByUsername(widget.username),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var randevular = snapshot.data!;
                      return ListView.builder(
                          itemCount: randevular.length,
                          itemBuilder: (context, index) {
                            var randevu = randevular[index];
                            DateTime tarih = DateTime.parse(randevu["randevuTarihi"]);
                            String duzenliTarih = DateFormat("yyyy-MM-dd").format(tarih);
                            return Container(
                              height: 80,
                              child: Card(color: Colors.orange,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(" Randevu Tarihi : " + duzenliTarih + " ", style: TextStyle(color: Colors.black),),
                                                Icon(Icons.date_range , color: Colors.black , size: 18,)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Randevu Saati : " + randevu["randevuSaati"] + " ", style: TextStyle(color: Colors.black),),
                                                Icon(Icons.timelapse_outlined , color: Colors.black, size: 18,)
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Text("Galeri Sahibi" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                              Text(randevu["galerici"]["name"] ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                      );
                    }else{
                      return Text("Randevu Bulunamadı.");
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
