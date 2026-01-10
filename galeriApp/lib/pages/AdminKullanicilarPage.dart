import 'package:flutter/material.dart';
import 'package:galeri_app/service/AdminKullanicilarimService.dart';

class Adminkullanicilarpage extends StatefulWidget {

  String galericiId;
  Adminkullanicilarpage({super.key, required this.galericiId});

  @override
  State<Adminkullanicilarpage> createState() => _AdminkullanicilarpageState();
}

class _AdminkullanicilarpageState extends State<Adminkullanicilarpage> {

  final AdminKullanicilarimService service = AdminKullanicilarimService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Kullanıcılar",
          style: TextStyle(color: Colors.orange),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: service.allKullanicilar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Kullanıcılar yüklenemedi",
                style: TextStyle(color: Colors.orange),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Kullanıcı yok",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
            );
          }
          final kullanicilar = snapshot.data!;

          return ListView.builder(
            itemCount: kullanicilar.length,
            itemBuilder: (context, index) {

              final kullanici = kullanicilar[index];

              return Card(
                color: Colors.orange,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: Text(
                    "${kullanici["isim"]} ${kullanici["soyisim"]}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    kullanici["telefonNo"] ?? "",
                    style: const TextStyle(color: Colors.black),
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
