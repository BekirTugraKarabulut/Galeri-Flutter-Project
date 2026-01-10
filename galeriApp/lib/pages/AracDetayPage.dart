import 'package:flutter/material.dart';
import 'package:galeri_app/pages/AracGuncellePage.dart';
import 'package:galeri_app/service/AracDetayService.dart';
import 'package:intl/intl.dart';

class Aracdetaypage extends StatefulWidget {

  final int aracId;

  Aracdetaypage({super.key, required this.aracId});

  @override
  State<Aracdetaypage> createState() => _AracdetaypageState();
}

class _AracdetaypageState extends State<Aracdetaypage> {
  Map<String, dynamic>? arac;
  bool isLoading = true;

  final AracDetayService aracDetayService = AracDetayService();

  String formatFiyat(dynamic fiyat) {
    final formatter = NumberFormat("#,##0", "tr_TR");
    return formatter.format(int.parse(fiyat.toString()));
  }

  @override
  void initState() {
    super.initState();
    _aracGetir();
  }

  Future<void> _aracGetir() async {
    final data = await aracDetayService.aracDetay(widget.aracId);
    setState(() {
      arac = data;
      isLoading = false;
    });
  }
  Widget _bilgiBox(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Araç Detayı",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "http://10.0.2.2:8086/uploads/${arac!['aracResmi']}",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            _bilgiBox("Marka", arac!['marka']),
            _bilgiBox("Model", arac!['model']),
            _bilgiBox("Yıl", arac!['yil'].toString()),
            _bilgiBox("Fiyat", "${formatFiyat(arac!['fiyat'])} ₺"),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        Aracguncellepage(aracId: widget.aracId),
                  ),
                );
                if (result != null) {
                  setState(() {
                    arac = result;
                  });
                }
              },
              child: const Text(
                "Güncelle",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
