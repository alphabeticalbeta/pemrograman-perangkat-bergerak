import 'package:flutter/material.dart';
import 'halaman_kontak.dart'; // Kita akan buat file ini di langkah selanjutnya

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD API Kontak',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HalamanKontak(),
    );
  }
}