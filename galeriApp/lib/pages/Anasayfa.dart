import 'package:flutter/material.dart';
import 'package:galeri_app/pages/GaleriHakkindaPage.dart';
import 'package:galeri_app/pages/KatalogPage.dart';
import 'package:galeri_app/pages/ProfilimPage.dart';
import 'package:galeri_app/pages/RandevuAlPage.dart';
import 'package:galeri_app/pages/RandevularimPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Anasayfa extends StatefulWidget {
  final String username;

  const Anasayfa({super.key, required this.username});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  int _selectedIndex = 0;
  PageController pageController = PageController();

  final list = [
    "images/galeri.jpeg",
    "images/key.jpeg",
    "images/lambo.jpeg"
  ];

  Widget _buildAnasayfa() {
    return Column(
      children: [
        SizedBox(
          height: 290,
          child: PageView.builder(
            controller: pageController,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Image.asset(list[index], width: 400, height: 290);
            },
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: pageController,
          count: list.length,
          effect: WormEffect(
            dotColor: Colors.white,
            activeDotColor: Colors.orange,
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(20),
                    topStart: Radius.circular(20),
                  ),
                  child: Image.asset("images/cars.jpeg", width: 138, height: 100)),
              Container(
                width: 160,
                height: 100,
                child: ElevatedButton(style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.orange
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(20),
                        topEnd: Radius.circular(20),
                      ),
                    ),
                  )
                ) , onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Katalogpage()));
                }, child: Text("Katalog İncele" , style: TextStyle(color:  Colors.black , fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(20),
                    topStart: Radius.circular(20),
                  ),
                  child: Image.asset("images/randevu.jpeg", width: 138, height: 100)),
              Container(
                width: 160,
                height: 100,
                child: ElevatedButton(style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Colors.orange
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(20),
                          topEnd: Radius.circular(20),
                        ),
                      ),
                    )
                ) , onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Randevualpage(username: widget.username)));
                }, child: Text("Randevu Al" , style: TextStyle(color:  Colors.black , fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ],
    );
  }
  List<Widget> get _pages => [
    _buildAnasayfa(),
    Randevularimpage(username: widget.username),
    Profilimpage(username: widget.username),
    const Galerihakkindapage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Randevularım",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profilim",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Galeri Bilgisi",
          ),
        ],
      ),
    );
  }
}

