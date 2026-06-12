import 'package:flutter/material.dart';

class TabMenuPage extends StatelessWidget {
  const TabMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. MEMBUNGKUS SELURUH HALAMAN DENGAN DefaultTabController
    return DefaultTabController(
      length: 3, // Mendefinisikan bahwa akan ada tepat 3 buah Tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Status Pengajuan Cuti'),
          backgroundColor: Colors.deepOrange,
          
          // 2. MENYISIPKAN TAB BAR DI BAGIAN BAWAH APPBAR
          bottom: const TabBar(
            indicatorColor: Colors.white, // Warna garis bawah pada tab yang aktif
            indicatorWeight: 4.0, // Ketebalan garis indikator
            tabs: [
              Tab(icon: Icon(Icons.hourglass_empty), text: 'Menunggu'),
              Tab(icon: Icon(Icons.check_circle), text: 'Disetujui'),
              Tab(icon: Icon(Icons.cancel), text: 'Ditolak'),
            ],
          ),
        ),
        
        // 3. MENGHUBUNGKAN KONTEN HALAMAN DENGAN TAB BAR
        body: const TabBarView(
          children: [
            // Konten untuk Tab 1 (Menunggu)
            Center(
              child: Text(
                '⏳ Tidak ada pengajuan cuti yang sedang menunggu.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            
            // Konten untuk Tab 2 (Disetujui)
            Center(
              child: Text(
                '✅ Pengajuan cuti tahunan Anda (3 Hari) telah disetujui.',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
            
            // Konten untuk Tab 3 (Ditolak)
            Center(
              child: Text(
                '❌ Pengajuan cuti alasan penting Anda ditolak.',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}