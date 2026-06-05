import 'package:flutter/material.dart';

class SyaratCutiPage extends StatelessWidget {
  const SyaratCutiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan Cuti'),
        backgroundColor: Colors.teal,
      ),
      
      // 1. MEMBUNGKUS DENGAN SingleChildScrollView
      // Jika widget ini dihapus, layar akan mengalami error Bottom Overflow
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        
        // 2. COLUMN SEBAGAI CHILD TUNGGAL
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Peraturan Cuti Tahunan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Kotak Konten 1 yang cukup tinggi (Mensimulasikan teks panjang)
            Container(
              height: 300,
              color: Colors.teal[100],
              padding: const EdgeInsets.all(16.0),
              child: const Text('1. Setiap pegawai berhak mendapatkan cuti tahunan sebanyak 12 hari kerja setelah bekerja minimal 1 tahun berturut-turut...\n\n(Bayangkan ini adalah teks peraturan yang sangat panjang)'),
            ),
            const SizedBox(height: 20),
            
            // Kotak Konten 2 yang cukup tinggi
            Container(
              height: 300,
              color: Colors.teal[200],
              padding: const EdgeInsets.all(16.0),
              child: const Text('2. Pengajuan cuti harus dilakukan selambat-lambatnya 7 hari sebelum tanggal pelaksanaan cuti melalui portal HR ini...'),
            ),
            const SizedBox(height: 20),
            
            // Kotak Konten 3 (Yang pasti menembus batas bawah layar standar)
            Container(
              height: 300,
              color: Colors.teal[300],
              padding: const EdgeInsets.all(16.0),
              child: const Text('3. Cuti besar dapat diajukan bagi pegawai yang telah mengabdi lebih dari 5 tahun...'),
            ),
            const SizedBox(height: 40),
            
            // Tombol Konfirmasi di bagian paling bawah
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Perintah untuk kembali ke halaman sebelumnya (Dashboard)
                  Navigator.pop(context);
                },
                child: const Text('Saya Setuju & Kembali'),
              ),
            )
          ],
        ),
      ),
    );
  }
}