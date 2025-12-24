import 'package:flutter/material.dart';
import 'package:galeri_app/service/ProfilService.dart';

class Profilimpage extends StatefulWidget {

  String username;

  Profilimpage({super.key, required this.username});

  @override
  State<Profilimpage> createState() => _ProfilimpageState();
}

class _ProfilimpageState extends State<Profilimpage> {
  
  ProfilService profilService = ProfilService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Image.asset("images/account.jpeg"),
            SizedBox(height: 20),
            FutureBuilder(
              future: profilService.profilBilgileri(widget.username),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var profil = snapshot.data!;

                  Widget buildInfoBox(String label, String value, IconData icon) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "$label : $value",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(icon, color: Colors.black),
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: [
                      buildInfoBox("Email", profil["username"], Icons.email),
                      buildInfoBox("İsim", profil["isim"], Icons.badge),
                      buildInfoBox("Soyisim", profil["soyisim"], Icons.person),
                      buildInfoBox("Telefon", profil["telefonNo"], Icons.phone),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator(color: Colors.orange);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.orange
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                )
              ),onPressed: (){

              }, child: Text("Güncelle",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
            )
          ],
        ),
      ),
    );
  }
}
