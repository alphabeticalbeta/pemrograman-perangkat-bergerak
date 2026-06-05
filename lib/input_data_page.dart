import 'package:flutter/material.dart';

// WAJIB MENGGUNAKAN StatefulWidget KARENA KITA MEMBUTUHKAN dispose() UNTUK CONTROLLER
class InputDataPage extends StatefulWidget {
  const InputDataPage({super.key});

  @override
  State<InputDataPage> createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  // 1. Inisialisasi Controller untuk menangkap teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();

  // 2. Fungsi bawaan untuk membersihkan memori saat halaman dihancurkan (ditutup)
  @override
  void dispose() {
    _namaController.dispose();
    _nikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Pegawai'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            // 3. TEXTFIELD UNTUK NAMA (KEYBOARD TEKS STANDAR)
            TextField(
              controller: _namaController, // Menyambungkan controller ke kotak ini
              keyboardType: TextInputType.text, // Memunculkan keyboard huruf
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama Anda...',
                prefixIcon: Icon(Icons.person), // Ikon di sebelah kiri dalam kotak
                border: OutlineInputBorder(), // Membuat bingkai kotak penuh keliling
              ),
            ),
            
            const SizedBox(height: 20), // Spasi vertikal antar inputan
            
            // 4. TEXTFIELD UNTUK NIK (KEYBOARD ANGKA)
            TextField(
              controller: _nikController, 
              keyboardType: TextInputType.number, // Otomatis memunculkan Numpad angka
              decoration: const InputDecoration(
                labelText: 'Nomor Induk Karyawan (NIK)',
                hintText: 'Contoh: 12345678',
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // 5. TOMBOL UNTUK MEMBACA ISI INPUTAN DARI CONTROLLER
            SizedBox(
              width: double.infinity, // Memaksa tombol membentang penuh ke kiri-kanan
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {
                  // Cara mengambil teks dari controller adalah memanggil ".text"
                  String namaInput = _namaController.text;
                  String nikInput = _nikController.text;
                  
                  // Menampilkan hasil tangkapan ke console/terminal
                  debugPrint('--- DATA TERSIMPAN ---');
                  debugPrint('Nama : $namaInput');
                  debugPrint('NIK  : $nikInput');
                },
                child: const Text(
                  'Simpan Data', 
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}