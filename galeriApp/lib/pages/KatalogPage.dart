import 'package:flutter/material.dart';
import 'package:galeri_app/service/AracGetAllService.dart';

class Katalogpage extends StatefulWidget {
  const Katalogpage({super.key});

  @override
  State<Katalogpage> createState() => _KatalogpageState();
}

class _KatalogpageState extends State<Katalogpage> {

  final AracGetAllService _aracGetAllService = AracGetAllService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.orange),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Katalog",
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
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "http://10.0.2.2:8086/uploads/${arac['aracResmi']}",
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
