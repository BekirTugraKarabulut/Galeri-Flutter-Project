import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:galeri_app/service/AdminRandevularService.dart';
import 'package:galeri_app/service/RandevuSilService.dart';

class Adminrandevularpage extends StatefulWidget {
  String galericiId;
  Adminrandevularpage({super.key, required this.galericiId});

  @override
  State<Adminrandevularpage> createState() => _AdminrandevularpageState();
}

class _AdminrandevularpageState extends State<Adminrandevularpage> {
  AdminRandevularService adminRandevularService = AdminRandevularService();
  RandevuSilService randevuSilService = RandevuSilService();

  void randevuSilDialog(int randevuId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.orange,
          titlePadding: EdgeInsets.only(top: 20, left: 120, right: 24),
          title: const Text("Uyarı" , style: TextStyle(color:  Colors.black , fontWeight: FontWeight.bold),),
          content: const Text("Bu randevuyu silmek istiyor musunuz?" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Hayır" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                final success =
                await randevuSilService.randevuSil(randevuId);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(backgroundColor: Colors.orange,content: Text("Randevu silindi",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
                  );
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(backgroundColor: Colors.orange,content: Text("Randevu silinemedi",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
                  );
                }
              },
              child: const Text("Evet", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
        ),
        title:
        const Text("Randevular", style: TextStyle(color: Colors.orange)),
      ),
      body: FutureBuilder(
        future: adminRandevularService.tumRandevuListesi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Randevu Yok",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
            );
          }

          var randevularListesi = snapshot.data!;

          return ListView.builder(
            itemCount: randevularListesi.length,
            itemBuilder: (context, index) {
              var randevu = randevularListesi[index];
              DateTime tarih =
              DateTime.parse(randevu["randevuTarihi"]);
              String duzenliTarih =
              DateFormat("yyyy-MM-dd").format(tarih);

              return SizedBox(
                height: 90,
                child: Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Müşteri Adı : ${randevu["kullanici"]["isim"]} ${randevu["kullanici"]["soyisim"]}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Randevu Tarihi : $duzenliTarih"),
                              Text(
                                  "Randevu Saati : ${randevu["randevuSaati"]}"),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.clear,
                              color: Colors.red),
                          onPressed: () {
                            randevuSilDialog(randevu["randevuId"]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
