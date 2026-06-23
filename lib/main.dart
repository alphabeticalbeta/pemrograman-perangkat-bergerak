import 'package:flutter/material.dart';
import 'ui/halaman_catatan.dart'; // Wajib di-import agar main.dart mengenali HalamanCatatan

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Catatan SQLite',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HalamanCatatan(), // Mengarahkan layar pertama ke UI SQLite kita
    );
  }
}