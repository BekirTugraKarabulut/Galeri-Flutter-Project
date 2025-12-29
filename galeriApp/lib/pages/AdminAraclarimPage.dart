import 'package:flutter/material.dart';
import 'package:galeri_app/service/AracGetAllService.dart';
import 'package:galeri_app/service/AracSilService.dart';

class Adminaraclarimpage extends StatefulWidget {
  const Adminaraclarimpage({super.key});

  @override
  State<Adminaraclarimpage> createState() => _AdminaraclarimpageState();
}

class _AdminaraclarimpageState extends State<Adminaraclarimpage> {
  final AracGetAllService _aracGetAllService = AracGetAllService();
  final AracSilService _aracSilService = AracSilService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Araçlarım",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _aracGetAllService.getAllArac(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Araç bulunamadı",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final araclar = snapshot.data!;

          return GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
            children: araclar.map((arac) {
              return Stack(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 130,
                            width: double.infinity,
                            child: Image.network(
                              "http://10.0.2.2:8086/uploads/${arac['aracResmi']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${arac['marka']} ${arac['model']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Yıl: ${arac['yil']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Fiyat: ${arac['fiyat']} ₺",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    right: 6,
                    top: 6,
                    child: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.red),
                      onPressed: () async {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Onay"),
                            content: const Text(
                              "Arabayı silmek istediğinize emin misiniz?",
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Hayır"),
                                onPressed: () => Navigator.pop(ctx, false),
                              ),
                              TextButton(
                                child: const Text("Evet"),
                                onPressed: () => Navigator.pop(ctx, true),
                              ),
                            ],
                          ),
                        );

                        if (result == true) {
                          final success = await _aracSilService
                              .aracSil(arac['aracId']);

                          if (success) {
                            setState(() {}); // listeyi yeniler
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Araç silindi")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text("Silme işlemi başarısız!")),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
