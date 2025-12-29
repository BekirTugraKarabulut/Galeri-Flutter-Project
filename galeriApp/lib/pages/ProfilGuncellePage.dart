import 'package:flutter/material.dart';
import 'package:galeri_app/service/ProfilService.dart';
import 'package:galeri_app/service/ProfilGuncelleService.dart';

class Profilguncellepage extends StatefulWidget {
  final String username;

  const Profilguncellepage({super.key, required this.username});

  @override
  State<Profilguncellepage> createState() => _ProfilguncellepageState();
}

class _ProfilguncellepageState extends State<Profilguncellepage> {
  late TextEditingController usernameController;
  late TextEditingController isimController;
  late TextEditingController soyisimController;
  late TextEditingController telefonController;

  final ProfilService profilService = ProfilService();
  final ProfilGuncelleService profilGuncelleService = ProfilGuncelleService();

  bool loading = true;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController(text: widget.username);
    isimController = TextEditingController();
    soyisimController = TextEditingController();
    telefonController = TextEditingController();

    _loadProfil();
  }

  Future<void> _loadProfil() async {
    try {
      final data = await profilService.profilBilgileri(widget.username);

      setState(() {
        usernameController.text = data["username"] ?? "";
        isimController.text = data["isim"] ?? "";
        soyisimController.text = data["soyisim"] ?? "";
        telefonController.text = data["telefonNo"] ?? "";
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil bilgileri alınamadı")),
      );
    }
  }

  Future<void> _kaydet() async {
    final sonuc = await profilGuncelleService.updateKullaniciBilgileri(
      usernameController.text,
      isimController.text,
      soyisimController.text,
      telefonController.text,
    );

    if (sonuc) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil başarıyla güncellendi")),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil güncellenemedi")),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    isimController.dispose();
    soyisimController.dispose();
    telefonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.orange),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Profil Güncelle",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "images/account.jpeg",
                height: 230,
                width: 350,
              ),
              const SizedBox(height: 20),

              TextField(
                style: const TextStyle(color: Colors.orange),
                controller: usernameController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Kullanıcı Adı",
                  filled: true,
                  fillColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                style: const TextStyle(color: Colors.orange),
                controller: isimController,
                decoration: const InputDecoration(
                  labelText: "İsim",
                  filled: true,
                  fillColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                style: const TextStyle(color: Colors.orange),
                controller: soyisimController,
                decoration: const InputDecoration(
                  labelText: "Soyisim",
                  filled: true,
                  fillColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                style: const TextStyle(color: Colors.orange),
                controller: telefonController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Telefon",
                  filled: true,
                  fillColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _kaydet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  "Kaydet",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
