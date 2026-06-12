import 'package:flutter/material.dart';
// Import file halaman Bagian 1 (akan kita buat setelah ini)
import 'syarat_cuti_page.dart'; 
// Import file halaman Bagian 2 (akan kita buat setelah ini)
import 'daftar_pegawai_page.dart';
// Import file halaman Bagian 3 (akan kita buat setelah ini)
import 'dashboard_menu_page.dart';
// Import file halaman Bagian 4 (akan kita buat setelah ini)
import 'input_data_page.dart';
// Import file halaman Bagian 5 (akan kita buat setelah ini)
import 'form_validasi_page.dart';
// Import file halaman Bagian 6 (akan kita buat setelah ini)
import 'bottom_nav_page.dart';
// Import file halaman Bagian 7 (akan kita buat setelah ini)
import 'drawer_menu_page.dart';
// Import file halaman Bagian 8 (akan kita buat setelah ini)
import 'tab_menu_page.dart';
// Import file halaman Bagian 9 (akan kita buat setelah ini)
import 'interaksi_khusus_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HR Portal App',
      theme: ThemeData(primarySwatch: Colors.blue),
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
        title: const Text('Modul 11 dan 12: HR Portal'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Tombol Navigasi ke Materi Bagian 1
          ElevatedButton(
            onPressed: () {
              // Perintah Navigasi untuk berpindah halaman ke SyaratCutiPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SyaratCutiPage()),
              );
            },
            child: const Text('Bagian 1: Scrollable Widget (Syarat Cuti)'),
          ),
          const SizedBox(height: 16), // Spasi pemisah antar tombol

          // Tombol Navigasi ke Materi Bagian 2
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DaftarPegawaiPage()),
              );
            },
            child: const Text('Bagian 2: ListView (Daftar Pegawai)'),
          ),
          
          const SizedBox(height: 16), // Spasi pemisah antar tombol

          // Tombol Navigasi ke Materi Bagian 3
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardMenuPage()),
              );
            },
            child: const Text('Bagian 3: GridView (Dashboard Menu)'),
          ),

          // ... (Tombol Bagian 3 sebelumnya) ...

          const SizedBox(height: 16), // Spasi pemisah antar tombol

          // Tombol Navigasi ke Materi Bagian 4
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InputDataPage()),
              );
            },
            child: const Text('Bagian 4: TextField (Input Data)'),
          ),

          // ... (Tombol Bagian 4 sebelumnya) ...

          const SizedBox(height: 16), // Spasi pemisah antar tombol

          // Tombol Navigasi ke Materi Bagian 5
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormValidasiPage()),
              );
            },
            child: const Text('Bagian 5: Validasi Form'),
          ),

          const SizedBox(height: 16),

          // Tombol Navigasi ke Materi Bagian 6
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BottomNavPage()),
              );
            },
            child: const Text('Bagian 6: Bottom Navigation Bar'),
          ),


          const SizedBox(height: 16),

          // Tombol Navigasi ke Materi Bagian 7
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DrawerMenuPage()),
              );
            },
            child: const Text('Bagian 7: Drawer (Menu Samping)'),
          ),

          const SizedBox(height: 16),

          // Tombol Navigasi ke Materi Bagian 8
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TabMenuPage()),
              );
            },
            child: const Text('Bagian 8: TabBar (Status Cuti)'),
          ),
          
          // Ruang untuk tombol-tombol Bagian , 3, dst nantinya...
          const SizedBox(height: 16),

          // Tombol Navigasi ke Materi Bagian 9
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InteraksiKhususPage()),
              );
            },
            child: const Text('Bagian 9: AlertDialog & BottomSheet'),
          ),

        ],
      ),
    );
  }
}