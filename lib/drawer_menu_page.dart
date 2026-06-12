import 'package:flutter/material.dart';

class DrawerMenuPage extends StatelessWidget {
  const DrawerMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman dengan Drawer'),
        backgroundColor: Colors.indigo,
        // Catatan: Kita tidak menambahkan ikon menu di sini. 
        // Flutter akan menambahkannya otomatis karena kita menggunakan properti 'drawer' di bawah.
      ),
      
      // 1. MENAMBAHKAN PROPERTI DRAWER PADA SCAFFOLD
      drawer: Drawer(
        // 2. MENGGUNAKAN LISTVIEW AGAR MENU BISA DI-SCROLL
        child: ListView(
          padding: EdgeInsets.zero, // Menghilangkan jarak putih bawaan di bagian paling atas
          children: [
            
            // 3. MEMBUAT HEADER PROFIL STANDAR GOOGLE
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              accountName: Text(
                'Budi Santoso',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text('budi.santoso@hr-portal.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.indigo),
              ),
            ),
            
            // 4. DAFTAR MENU MENGGUNAKAN LISTTILE
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan Akun'),
              onTap: () {
                // Praktik UX yang baik: Tutup drawer terlebih dahulu sebelum melakukan aksi lain
                Navigator.pop(context); 
                debugPrint('Membuka Pengaturan...');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Pusat Bantuan'),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Membuka Pusat Bantuan...');
              },
            ),
            
            const Divider(), // Garis pemisah
            
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Keluar', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Proses Logout...');
              },
            ),
            
          ],
        ),
      ),
      
      // Area utama halaman
      body: const Center(
        child: Text(
          'Geser layar dari kiri ke kanan\natau tekan ikon menu di pojok kiri atas',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}