import 'package:flutter/material.dart';
import 'package:galeri_app/pages/Anasayfa.dart';
import 'package:galeri_app/pages/ButtonPage.dart';
import 'package:galeri_app/pages/FirstPage.dart';
import 'package:galeri_app/pages/LoginPage.dart';
import 'package:galeri_app/pages/RegisterPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/firstpage': (context) => const Firstpage(),
        "/registerpage": (context) => const Registerpage(),
        "/buttonpage": (context) => const Buttonpage(),
        "/loginpage": (context) => const Loginpage(),
        "/anasayfa": (context) => const Anasayfa(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Firstpage(),
    );
  }
}

