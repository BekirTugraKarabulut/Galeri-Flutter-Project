import 'package:flutter/material.dart';
import 'package:galeri_app/service/AracDetayService.dart';
import 'package:galeri_app/service/ArabaDetayGuncellemeService.dart';

class Aracguncellepage extends StatefulWidget {

  final int aracId;
  const Aracguncellepage({super.key, required this.aracId});

  @override
  State<Aracguncellepage> createState() => _AracguncellepageState();
}

class _AracguncellepageState extends State<Aracguncellepage> {

  final _markaController = TextEditingController();
  final _modelController = TextEditingController();
  final _yilController = TextEditingController();
  final _fiyatController = TextEditingController();

  final AracDetayService _detayService = AracDetayService();
  final ArabaDetayGuncellemeService _guncelleService =
  ArabaDetayGuncellemeService();

  String? aracResmi;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _aracDetayGetir();
  }

  Future<void> _aracDetayGetir() async {
    final arac = await _detayService.aracDetay(widget.aracId);

    setState(() {
      aracResmi = arac["aracResmi"];
      _markaController.text = arac["marka"];
      _modelController.text = arac["model"];
      _yilController.text = arac["yil"].toString();
      _fiyatController.text = arac["fiyat"].toString();
      isLoading = false;
    });
  }

  Future<void> _guncelle() async {
    final yil = int.tryParse(_yilController.text);
    final fiyat = double.tryParse(_fiyatController.text);

    if (_markaController.text.isEmpty ||
        _modelController.text.isEmpty ||
        _yilController.text.isEmpty ||
        _fiyatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: const Text(
            "Lütfen tüm alanları doldurun",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          action: SnackBarAction(
            textColor: Colors.black,
            label: "Tamam",
            onPressed: () {},
          ),
        ),
      );
      return;
    }

    final currentYear = DateTime.now().year;
    if (yil == null || yil < 1950 || yil > currentYear) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Yıl 1950 ile $currentYear arasında olmalıdır",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          action: SnackBarAction(
            textColor: Colors.black,
            label: "Tamam",
            onPressed: () {},
          ),
        ),
      );
      return;
    }

    if (fiyat == null || fiyat < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: const Text(
            "Fiyat negatif olamaz",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          action: SnackBarAction(
            textColor: Colors.black,
            label: "Tamam",
            onPressed: () {},
          ),
        ),
      );
      return;
    }

    final success = await _guncelleService.guncelleArabaDetay(
      widget.aracId,
      _markaController.text,
      _modelController.text,
      yil,
      _fiyatController.text,
    );

    if (success) {
      final guncellenmisArac = {
        "aracId": widget.aracId,
        "marka": _markaController.text,
        "model": _modelController.text,
        "yil": yil,
        "fiyat": _fiyatController.text,
        "aracResmi": aracResmi,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Araç başarıyla güncellendi",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );
      Navigator.pop(context, guncellenmisArac);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: const Text(
            "Güncelleme başarısız",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          action: SnackBarAction(
            label: "Tamam",
            onPressed: () {},
          ),
        ),
      );
    }
  }

  Widget _textField(TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Araç Güncelle", style: TextStyle(color: Colors.orange)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                "http://10.0.2.2:8086/uploads/$aracResmi",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.car_rental,
                  size: 80,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _textField(_markaController),
            _textField( _modelController),
            _textField( _yilController,
                type: TextInputType.number),
            _textField( _fiyatController,
                type: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _guncelle,
              child: const Text(
                "Güncelle",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
