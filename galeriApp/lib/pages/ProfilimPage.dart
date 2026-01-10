import 'package:flutter/material.dart';
import 'package:galeri_app/pages/ProfilGuncellePage.dart';
import 'package:galeri_app/service/ProfilService.dart';

class Profilimpage extends StatefulWidget {
  final String username;

  Profilimpage({super.key, required this.username});

  @override
  State<Profilimpage> createState() => _ProfilimpageState();
}

class _ProfilimpageState extends State<Profilimpage> {
  final ProfilService profilService = ProfilService();

  Map<String, dynamic>? profil;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfil();
  }

  Future<void> _loadProfil() async {
    setState(() => loading = true);

    final data = await profilService.profilBilgileri(widget.username);

    setState(() {
      profil = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 25),
            child: IconButton(
              icon: const Icon(
                Icons.login_outlined,
                color: Colors.red,
                size: 25,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.orange,
                      titlePadding: EdgeInsets.only(top: 20, left: 125, right: 24),
                      title: const Text("Uyarı" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      content: const Text(
                        "Uygulamadan çıkış yapmak istiyor musunuz?", style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Hayır" , style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacementNamed(
                                context, "/buttonpage");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(backgroundColor: Colors.orange,
                                content: Text("Çıkış yaptınız.",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                              ),
                            );
                          },
                          child: const Text(
                            "Evet",
                            style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator(color: Colors.orange)
            : Column(
          children: [
            Image.asset("images/account.jpeg"),
            const SizedBox(height: 20),

            _buildInfoBox("Email", profil!["username"] ?? "", Icons.email),
            _buildInfoBox("İsim", profil!["isim"] ?? "", Icons.badge),
            _buildInfoBox("Soyisim", profil!["soyisim"] ?? "", Icons.person),
            _buildInfoBox("Telefon", profil!["telefonNo"] ?? "", Icons.phone),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Güncelle",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profilguncellepage(
                        username: widget.username,
                      ),
                    ),
                  );

                  if (result == true) {
                    _loadProfil();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value, IconData icon) {
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
}
