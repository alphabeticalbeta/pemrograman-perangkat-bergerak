import 'package:flutter/material.dart';

class DetailPegawaiPage extends StatelessWidget {
  // 1. Mendefinisikan variabel penampung data yang dikirim
  final String namaPegawai;

  // 2. Konstruktor yang mewajibkan halaman asal untuk mengirimkan data nama
  const DetailPegawaiPage({super.key, required this.namaPegawai});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Karyawan'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menampilkan ikon user besar sebagai placeholder foto
              const Icon(Icons.account_circle, size: 120, color: Colors.blue),
              const SizedBox(height: 20),
              
              // 3. Menampilkan data nama secara dinamis sesuai variabel
              Text(
                namaPegawai,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 10),
              const Text(
                'Status Kepegawaian: Aktif',
                style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              
              // Tombol untuk kembali
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}