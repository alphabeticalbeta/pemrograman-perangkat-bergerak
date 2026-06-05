import 'package:flutter/material.dart';

class DashboardMenuPage extends StatelessWidget {
  const DashboardMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulasi data menu utama berupa gabungan Teks, Ikon, dan Warna (Map)
    final List<Map<String, dynamic>> daftarMenu = [
      {'judul': 'Absensi', 'ikon': Icons.fingerprint, 'warna': Colors.blue},
      {'judul': 'Cuti', 'ikon': Icons.calendar_today, 'warna': Colors.orange},
      {'judul': 'Slip Gaji', 'ikon': Icons.receipt, 'warna': Colors.green},
      {'judul': 'Klaim', 'ikon': Icons.account_balance_wallet, 'warna': Colors.red},
      {'judul': 'Profil', 'ikon': Icons.person, 'warna': Colors.purple},
      {'judul': 'Pengaturan', 'ikon': Icons.settings, 'warna': Colors.grey},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Menu'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        
        // MENGGUNAKAN GridView.builder UNTUK TATA LETAK KOTAK-KOTAK
        child: GridView.builder(
          itemCount: daftarMenu.length,
          
          // 1. GridDelegate: Mengatur arsitektur grid (jumlah kolom & jarak)
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Membagi layar menjadi 2 kolom menyamping
            crossAxisSpacing: 12.0, // Spasi horizontal antar kotak
            mainAxisSpacing: 12.0, // Spasi vertikal antar kotak
            childAspectRatio: 1.0, // Rasio ukuran kotak (1.0 = persegi sempurna)
          ),
          
          // 2. ItemBuilder: Membangun visualisasi setiap kotak menu
          itemBuilder: (context, index) {
            // Menggunakan Card untuk memberikan efek timbul/bayangan pada kotak
            return Card(
              elevation: 4, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), 
              ),
              // InkWell membuat Card ini memiliki efek gelombang (ripple) saat disentuh
              child: InkWell(
                onTap: () {
                  debugPrint('Menu ${daftarMenu[index]['judul']} diklik');
                },
                borderRadius: BorderRadius.circular(15.0),
                
                // Menyusun Ikon dan Teks di tengah-tengah kotak
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Icon(
                      daftarMenu[index]['ikon'],
                      size: 50.0,
                      color: daftarMenu[index]['warna'],
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      daftarMenu[index]['judul'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}