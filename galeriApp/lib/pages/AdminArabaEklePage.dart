import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:galeri_app/service/ArabaEkleService.dart';
import 'package:galeri_app/service/image_upload_service.dart';

class Adminarabaeklepage extends StatefulWidget {

  String galericiId;
  Adminarabaeklepage({super.key , required this.galericiId});

  @override
  State<Adminarabaeklepage> createState() => _AdminarabaeklepageState();
}

class _AdminarabaeklepageState extends State<Adminarabaeklepage> {
  final TextEditingController markaController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yilController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;
  String? uploadedFileName;

  ArabaEkleService arabaEkleService = ArabaEkleService();

  Future<XFile?> pickImage() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.orange),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Araba Ekle",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset("images/admin.jpeg", height: 120 , width: 120,),
              const SizedBox(height: 25),
              buildField(markaController, "Marka"),
              const SizedBox(height: 12),
              buildField(modelController, "Model"),
              const SizedBox(height: 12),
              buildField(yilController, "Yıl"),
              const SizedBox(height: 12),
              buildField(fiyatController, "Fiyat"),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () async {
                  final picked = await pickImage();
                  if (picked == null) return;

                  setState(() => selectedImage = picked);

                  uploadedFileName = await uploadImage(picked);

                  if (uploadedFileName == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Resim yüklenemedi")),
                    );
                  }
                },
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  "Resim Seç",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 12),

              if (selectedImage != null)
                Image.file(
                  File(selectedImage!.path),
                  height: 140,
                ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () async {

                  if(markaController.text.isEmpty || modelController.text.isEmpty || yilController.text.isEmpty || fiyatController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.orange ,content: Text("Tüm alanları doldurmalısın !" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),
                      ),
                    );
                    return;
                  }

                  if (0 > int.parse(fiyatController.text)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.orange,content: Text("Araba fiyatı 0'dan büyük olmalı",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),)
                    );
                    return;
                  }

                  if( 1950 > int.parse(yilController.text) || int.parse(yilController.text) > DateTime.now().year){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.orange,content: Text("Araba yılı 1950 ile ${DateTime.now().year} arasında olmalı" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),)
                    );
                    return;
                  }

                  if (uploadedFileName == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.orange,content: Text("Arac resim seçmelisin", style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),
                      ),
                    );
                    return;
                  }

                  bool response = await arabaEkleService.arabaEkle(
                    markaController.text,
                    modelController.text,
                    int.parse(yilController.text),
                    fiyatController.text,
                    uploadedFileName!,
                    widget.galericiId,
                  );

                  if (response) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.orange,content: Text("Araba eklendi",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      action: SnackBarAction(textColor: Colors.black,label: "Tamam", onPressed: (){}),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(backgroundColor: Colors.orange,
                          content: Text("Araba eklenirken hata oluştu",style: TextStyle(color: Colors.black),)),
                    );
                  }
                },
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  "Ekle",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(TextEditingController c, String hint) {
    return TextField(
      controller: c,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.orange,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
