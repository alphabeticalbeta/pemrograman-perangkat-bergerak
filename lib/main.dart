import 'package:flutter/material.dart';
// Nantinya kita akan meng-import file halaman Bagian 1 di sini
import 'asinkron_dasar_page.dart'; 
// Nantinya kita akan meng-import file halaman Bagian 2 di sini
import 'get_data_page.dart';
// Nantinya kita akan meng-import file halaman Bagian 3 di sini
import 'future_builder_page.dart';
// Nantinya kita akan meng-import file halaman Bagian 4 di sini
import 'post_data_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi REST API',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HalamanMenuUtama(),
    );
  }
}

class HalamanMenuUtama extends StatelessWidget {
  const HalamanMenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul 13: Belajar API'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Tombol Navigasi ke Materi Bagian 1
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AsinkronDasarPage()),
              );
            },
            child: const Text('Bagian 1: Konsep Asinkron (Future & Await)'),
          ),

          const SizedBox(height: 20),
          
          // Tombol Navigasi ke Materi Bagian 2
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetDataPage()),
              );
            },
            child: const Text('Bagian 2: GET Request (Tarik Data API)'),
          ),

          const SizedBox(height: 20),
          
          // Tombol Navigasi ke Materi Bagian 3
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FutureBuilderPage()),
              );
            },
            child: const Text('Bagian 3: FutureBuilder (Otomatis)'),
          ),

          const SizedBox(height: 20),
          
          // Tombol Navigasi ke Materi Bagian 4
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostDataPage()),
              );
            },
            child: const Text('Bagian 4: POST Request (Kirim Data API)'),
          ),
        ],
      ),
    );
  }
}