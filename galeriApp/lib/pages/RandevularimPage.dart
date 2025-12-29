import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:galeri_app/service/KullaniciRandevularimService.dart';
import 'package:galeri_app/service/RandevuSilService.dart';

class Randevularimpage extends StatefulWidget {
  String username;

  Randevularimpage({super.key, required this.username});

  @override
  State<Randevularimpage> createState() => _RandevularimpageState();
}

class _RandevularimpageState extends State<Randevularimpage> {
  final KullaniciRandevularimService kullaniciRandevularimService =
  KullaniciRandevularimService();

  final RandevuSilService randevuSilService = RandevuSilService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Randevularım", style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: kullaniciRandevularimService
                  .randevularByUsername(widget.username),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.orange));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("Randevu Bulunamadı.", style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final randevular = snapshot.data!;

                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: randevular.length,
                  itemBuilder: (context, index) {
                    final r = randevular[index];
                    final tarih = DateTime.parse(r["randevuTarihi"]);
                    final duzenliTarih =
                    DateFormat("yyyy-MM-dd").format(tarih);
                    return Card(
                      color: Colors.orange,
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        title: Text(
                          "Randevu Tarihi : $duzenliTarih",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "Randevu Saati : ${r["randevuSaati"]}",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.clear, fontWeight: FontWeight.bold ,color: Colors.red),
                          onPressed: () =>
                              _showDeleteDialog(r["randevuId"]),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int randevuId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Randevu Sil"),
        content:
        Text("Randevuyu silmek istediğinize emin misiniz ?"),
        actions: [
          TextButton(
            child: Text("Hayır"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Evet"),
            onPressed: () async {
              Navigator.pop(context);
              final sonuc = await randevuSilService.randevuSil(randevuId);
              if (sonuc) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Randevu silindi")),
                );
                setState(() {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Silme işlemi başarısız")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}