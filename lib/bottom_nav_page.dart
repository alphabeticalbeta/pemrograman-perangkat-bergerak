import 'package:flutter/material.dart';

// WAJIB MENGGUNAKAN StatefulWidget KARENA TAMPILAN AKAN BERUBAH-UBAH
class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  // 1. Variabel penentu tab aktif (dimulai dari indeks 0, yaitu tab pertama)
  int _selectedIndex = 0;

  // 2. Daftar konten halaman untuk masing-masing tab
  final List<Widget> _daftarHalaman = [
    const Center(child: Text('🏠 Halaman Beranda', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    const Center(child: Text('👥 Halaman Karyawan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    const Center(child: Text('👤 Halaman Profil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
  ];

  // 3. Fungsi pengubah status saat tab diklik oleh pengguna
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Memperbarui nilai indeks dengan tab yang baru diklik
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigasi Utama HR'),
        backgroundColor: Colors.teal,
      ),
      
      // Body akan menampilkan konten dari List berdasarkan indeks saat ini
      body: _daftarHalaman[_selectedIndex],
      
      // 4. MEMBANGUN MENU NAVIGASI BAWAH
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Memberi tahu sistem tab mana yang harus disorot/menyala
        selectedItemColor: Colors.teal, // Warna ikon & teks saat aktif
        unselectedItemColor: Colors.grey, // Warna ikon & teks saat tidak aktif
        onTap: _onItemTapped, // Mengeksekusi fungsi ubah indeks saat ikon ditekan
        
        // Menyusun daftar tombol tab di bagian bawah
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Karyawan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}