import 'package:flutter/material.dart';

class Randevularimpage extends StatefulWidget {

  String username;

  Randevularimpage({super.key, required this.username});

  @override
  State<Randevularimpage> createState() => _RandevularimpageState();
}

class _RandevularimpageState extends State<Randevularimpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Randevularım",style: TextStyle(color: Colors.orange),),
      ),
    );
  }
}
