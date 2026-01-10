import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _getLocation() async {
  bool enabled = await Geolocator.isLocationServiceEnabled();
  if (!enabled) throw 'Konum servisi kapalı';

  LocationPermission p = await Geolocator.checkPermission();
  if (p == LocationPermission.denied) {
    p = await Geolocator.requestPermission();
    if (p == LocationPermission.denied) throw 'İzin verilmedi';
  }

  if (p == LocationPermission.deniedForever) {
    throw 'Ayarlar → Konum izni vermen gerekiyor';
  }

  return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

class GaleriHakkindaPage extends StatefulWidget {
  const GaleriHakkindaPage({super.key});

  @override
  State<GaleriHakkindaPage> createState() => _GaleriHakkindaPageState();
}

class _GaleriHakkindaPageState extends State<GaleriHakkindaPage> {
  Future<LatLng>? _future;
  bool _showMap = false;

  void _loadMap() {
    setState(() {
      _showMap = true;
      _future = _getLocation().then(
            (p) => LatLng(p.latitude, p.longitude),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: Icon(Icons.add , color: Colors.black,),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Galeri Hakkında",style: TextStyle(color: Colors.orange),)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.directional(
                bottomStart: Radius.circular(0),
                bottomEnd: Radius.circular(0),
              ),
              child: Image.asset(
                "images/galeri.jpeg",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Universite Mahallesi Muhendislik D Blok /Malatya", style: TextStyle(color: Colors.white,fontSize: 15),
                ),
                SizedBox(width: 8),
                Icon(Icons.home_work_rounded , color: Colors.white,),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Bize Ulaşın : 0-545-466-88-57", style: TextStyle(color: Colors.white,fontSize: 16),
                ),
                SizedBox(width: 8),
                Icon(Icons.phone ,color: Colors.white,),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.orange
              )
            ),
              onPressed: _loadMap,
              icon: const Icon(Icons.location_on , color: Colors.black,),
              label: const Text("Konumu Görüntüle",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 16),
            if (_showMap)
              SizedBox(
                height: 320,
                child: FutureBuilder<LatLng>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Hata: ${snapshot.error}",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final pos = snapshot.data!;
                    return FlutterMap(
                      options: MapOptions(
                        initialCenter: pos,
                        initialZoom: 16,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'galeri_app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: pos,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_pin,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
