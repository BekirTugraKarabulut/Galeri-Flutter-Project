import 'package:flutter/material.dart';
import 'package:galeri_app/service/KullaniciFavorilerimService.dart';
import 'package:galeri_app/service/KullaniciFavoriSilmeService.dart';

class Favorilerimpage extends StatefulWidget {
  String username;
  Favorilerimpage({super.key, required this.username});

  @override
  State<Favorilerimpage> createState() => _FavorilerimpageState();
}

class _FavorilerimpageState extends State<Favorilerimpage> {
  final KullaniciFavorilerimService _favorilerService =
  KullaniciFavorilerimService();
  final KullaniciFavoriSilmeService _silmeService =
  KullaniciFavoriSilmeService();

  Future<List<Map<String, dynamic>>>? _futureFavoriler;

  @override
  void initState() {
    super.initState();
    _futureFavoriler = _favorilerService.favorilerim(widget.username);
  }

  Future<void> _yenile() async {
    setState(() {
      _futureFavoriler = _favorilerService.favorilerim(widget.username);
    });
  }

  Future<void> _favoriSilDialog(Map<String, dynamic> favori) async {
    final bool? onay = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Onay"),
        content: const Text(
            "Favorilerden kaldırmak istediğinize emin misiniz ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Hayır"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Evet",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (onay == true) {
      final favorilemeId = favori["favorilemeId"];

      final success =
      await _silmeService.kullaniciFavoriSilme(favorilemeId);

      if (success) {
        _yenile();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Favoriden kaldırıldı")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Silme işlemi sırasında hata oluştu")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Favorilerim",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureFavoriler,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.orange));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Favori listeniz boş",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final favorilerimList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: favorilerimList.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final favori = favorilerimList[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.network(
                              "http://10.0.2.2:8086/uploads/${favori["arac"]["aracResmi"]}",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Marka : ${favori["arac"]["marka"]}",
                              style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Model : ${favori["arac"]["model"]}",
                                style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Yıl : ${favori["arac"]["yil"]}",
                                style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Araç Fiyatı : ${favori["arac"]["fiyat"]} TL",
                                style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red),
                        onPressed: () => _favoriSilDialog(favori),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
