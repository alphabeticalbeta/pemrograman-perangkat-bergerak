import 'package:flutter/material.dart';
import 'detail_pegawai_page.dart';

class DaftarPegawaiPage extends StatelessWidget {
  const DaftarPegawaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulasi data dari database: Membuat 100 teks nama secara otomatis
    final List<String> daftarPegawai = List.generate(100, (index) => 'Pegawai Ke-${index + 1}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak Pegawai'),
        backgroundColor: Colors.blueAccent,
      ),
      
      // MENGGUNAKAN ListView.separated UNTUK DAFTAR YANG PANJANG & EFISIEN
      body: ListView.separated(
        itemCount: daftarPegawai.length, // 1. Menentukan total data yang akan dibangun
        
        // 2. Membangun garis pemisah (separator)
        separatorBuilder: (context, index) {
          return const Divider(); // Menampilkan garis horizontal tipis abu-abu
        },
        
        // 3. Membangun bentuk visual per baris data (item)
        itemBuilder: (context, index) {
          // ListTile adalah template baris bawaan Flutter yang sangat rapi
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text('${index + 1}'), // Menampilkan nomor urut di dalam lingkaran
            ),
            title: Text(
              daftarPegawai[index], 
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
            subtitle: const Text('Divisi IT & Pengembangan'),
            trailing: const Icon(Icons.call, color: Colors.green), // Ikon telepon di kanan
            onTap: () {
              // Menavigasi ke halaman detail sambil melempar data nama pegawai
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPegawaiPage(
                    namaPegawai: daftarPegawai[index], // Proses Passing Data dilakukan di sini
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}