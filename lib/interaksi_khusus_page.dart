import 'package:flutter/material.dart';

class InteraksiKhususPage extends StatelessWidget {
  const InteraksiKhususPage({super.key});

  // 1. FUNGSI UNTUK MEMUNCULKAN ALERT DIALOG (KONFIRMASI TENGAH LAYAR)
  void _tampilkanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus data pegawai ini? Tindakan ini tidak dapat dibatalkan.'),
          actions: [
            // Tombol Batal
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
            // Tombol Hapus (Merah)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
                debugPrint('Data berhasil dihapus dari sistem!');
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 2. FUNGSI UNTUK MEMUNCULKAN BOTTOM SHEET (PANEL DARI BAWAH)
  void _tampilkanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Melengkungkan sudut atas
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          // Menggunakan Column dengan MainAxisSize.min agar tinggi menyesuaikan isi
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              const Text('Opsi Lanjutan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Edit Data Pegawai'),
                onTap: () {
                  Navigator.pop(context); // Tutup panel
                  debugPrint('Membuka form edit...');
                },
              ),
              
              ListTile(
                leading: const Icon(Icons.share, color: Colors.green),
                title: const Text('Bagikan Profil'),
                onTap: () {
                  Navigator.pop(context); // Tutup panel
                  debugPrint('Membagikan profil ke WhatsApp...');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jendela Interaksi'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Tombol Pemicu Alert Dialog
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => _tampilkanDialog(context),
              icon: const Icon(Icons.warning, color: Colors.white),
              label: const Text('Hapus Data Pegawai', style: TextStyle(color: Colors.white)),
            ),
            
            const SizedBox(height: 20),
            
            // Tombol Pemicu Bottom Sheet
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () => _tampilkanBottomSheet(context),
              icon: const Icon(Icons.menu_open, color: Colors.white),
              label: const Text('Tampilkan Opsi Lanjutan', style: TextStyle(color: Colors.white)),
            ),
            
          ],
        ),
      ),
    );
  }
}