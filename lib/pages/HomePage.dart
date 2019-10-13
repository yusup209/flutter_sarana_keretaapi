import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: Text("Beranda"),
      ),
      body: Container(
        child: Center(
          child: Text("Selamat datang di aplikasi Sarana Perkretaapian!"),
        ),
      ),
    );
  }
}