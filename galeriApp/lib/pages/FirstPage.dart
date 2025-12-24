import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {

    Future<void> kayitSayfasinaGecis() async {
        await Future.delayed(const Duration(seconds: 4));
        Navigator.pushReplacementNamed(context, "/buttonpage");
    }

    @override
  void initState() {
      kayitSayfasinaGecis();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Lottie.asset("assets/cars.json" , width: 450 , height: 450),
          ],
        ),
      ),
    );
  }
}
