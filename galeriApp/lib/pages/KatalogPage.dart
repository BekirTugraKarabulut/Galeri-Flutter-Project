import 'package:flutter/material.dart';
import 'package:galeri_app/service/AracGetAllService.dart';
import 'package:galeri_app/service/KullaniciFavoriEkleService.dart';
import 'package:galeri_app/service/KullaniciFavorilerimService.dart';
import 'package:galeri_app/service/KullaniciFavoriSilmeService.dart';
import 'package:galeri_app/service/MarkaService.dart';
import 'package:galeri_app/service/ModelService.dart';
import 'package:intl/intl.dart';

class Katalogpage extends StatefulWidget {

  String username;
  Katalogpage({super.key, required this.username});

  @override
  State<Katalogpage> createState() => _KatalogpageState();
}

class _KatalogpageState extends State<Katalogpage> {

  final AracGetAllService _aracGetAllService = AracGetAllService();
  final KullaniciFavoriEkleService _favoriService = KullaniciFavoriEkleService();
  final KullaniciFavorilerimService _favorilerimService = KullaniciFavorilerimService();
  final KullaniciFavoriSilmeService _favoriSilService = KullaniciFavoriSilmeService();
  final MarkaService _markaService = MarkaService();
  final ModelService _modelService = ModelService();

  final Set<int> favoriteIds = {};
  final Map<int, int> aracToFavoriId = {};
  bool favLoading = false;

  String? selectedMarka;
  String? selectedModel;

  Future<List<Map<String, dynamic>>>? _futureAraclar;

  final List<String> markalar = ["Tüm Araçlar", "Audi" , "Aston Martin" , "BMW", "Ferrari" , "Ford" , "Lamborghini" , "Mercedes"  , "Nissan" , "Porsche", "Renault" ,"Skoda" ];
  final List<String> modeller = ["Tüm Araçlar",  "Aventador" , "E250" , "GTR" , "Kodiaq", "Koleos" , "Mustang",  "M5",   "R6" , "S63", "SF90", "V12" ,"X5", "911"];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _futureAraclar = _aracGetAllService.getAllArac();
  }

  String formatFiyat(dynamic fiyat) {
    final formatter = NumberFormat("#,##0", "tr_TR");
    return formatter.format(int.parse(fiyat.toString()));
  }


  Future<void> _loadFavorites() async {
    try {
      final list = await _favorilerimService.favorilerim(widget.username);

      setState(() {
        favoriteIds.clear();
        aracToFavoriId.clear();

        for (var f in list) {
          final aracId = f["arac"]["aracId"] as int;
          final favoriId = f["favorilemeId"] as int;

          favoriteIds.add(aracId);
          aracToFavoriId[aracId] = favoriId;
        }
      });
    } catch (_) {}
  }

  Future<void> _toggleFavorite(int aracId) async {
    if (favLoading) return;
    setState(() => favLoading = true);

    try {
      final bool isFavorite = favoriteIds.contains(aracId);

      if (isFavorite) {
        final favoriId = aracToFavoriId[aracId];
        if (favoriId != null) {
          final ok = await _favoriSilService.kullaniciFavoriSilme(favoriId);
          if (ok) {
            setState(() {
              favoriteIds.remove(aracId);
              aracToFavoriId.remove(aracId);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(backgroundColor: Colors.orange,
                content: Text("Araç favorilerden kaldırıldı", style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      } else {
        final ok = await _favoriService.favoriEkle(widget.username, aracId);
        if (ok) {
          await _loadFavorites();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(backgroundColor: Colors.orange,
              content: Text("Araç favorilere eklendi",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } finally {
      setState(() => favLoading = false);
    }
  }

  void _filtreCalistir() {

    setState(() {
      if (selectedMarka != null) {
        _futureAraclar = _markaService.markaGetAll(selectedMarka!);
      } else if (selectedModel != null) {
        _futureAraclar = _modelService.modelGetAll(selectedModel!);
      } else {
        _futureAraclar = _aracGetAllService.getAllArac();
      }
    });
  }

  Widget _dropdownContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: _dropdownContainer(
                    child: DropdownButton<String>(
                      value: selectedMarka,
                      hint: const Text(
                        "Marka",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
                      dropdownColor: Colors.orange,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: markalar.map((m) {
                        return DropdownMenuItem(
                          value: m == "Tüm Araçlar" ? null : m,
                          child: Text(
                            m,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        selectedMarka = v;
                        selectedModel = null;
                        _filtreCalistir();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _dropdownContainer(
                    child: DropdownButton<String>(
                      value: selectedModel,
                      hint: const Text(
                        "Model",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
                      dropdownColor: Colors.orange,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: modeller.map((m) {
                        return DropdownMenuItem(
                          value: m == "Tüm Araçlar" ? null : m,
                          child: Text(
                            m,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        selectedModel = v;
                        selectedMarka = null;
                        _filtreCalistir();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _futureAraclar,
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
                    final int aracId = arac["aracId"];
                    final bool isFavorite = favoriteIds.contains(aracId);

                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Column(
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
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Yıl: ${arac['yil']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Fiyat: ${formatFiyat(arac['fiyat'])} ₺",
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
                            Positioned(
                              right: -6,
                              top: -4,
                              child: IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: isFavorite
                                      ? Colors.orange
                                      : Colors.black,
                                ),
                                onPressed: () => _toggleFavorite(aracId),
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
          ),
        ],
      ),
    );
  }
}
