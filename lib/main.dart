import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanProfil(),
    );
  }
}

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Karyawan'),
        backgroundColor: Colors.blue,
      ),
body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Kita gunakan Column utama untuk membungkus Kartu Profil dan Menu Aksi
        child: Column(
          children: [
            // --- 1. KARTU PROFIL (KODE SEBELUMNYA) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: Column(
                children: [
                  Text('Budi Santoso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Text('Senior Mobile Developer'),
                  SizedBox(height: 4.0),
                  Text('NIK: 1992038847', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            
            // --- 2. JARAK PEMISAH ---
            SizedBox(height: 40.0), // Spasi transparan pemisah antara kartu dan menu
            
            // --- 3. MENU AKSI CEPAT (PRAKTIK ROW & COLUMN) ---
            Row(
              // mainAxisAlignment pada Row mengatur perataan horizontal
              // spaceEvenly: membagi sisa ruang kosong secara merata di antara setiap anak
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [
                
                // Menu 1: Absen (Ikon dan Teks disusun ke bawah dengan Column)
                Column(
                  children: [
                    Icon(Icons.fingerprint, size: 50.0, color: Colors.blue),
                    SizedBox(height: 8.0),
                    Text('Absen', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                
                // Menu 2: Cuti
                Column(
                  children: [
                    Icon(Icons.calendar_month, size: 50.0, color: Colors.orange),
                    SizedBox(height: 8.0),
                    Text('Cuti', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                
                // Menu 3: Slip Gaji
                Column(
                  children: [
                    Icon(Icons.receipt_long, size: 50.0, color: Colors.green),
                    SizedBox(height: 8.0),
                    Text('Slip Gaji', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                
              ],
            ),
            
            SizedBox(height: 40.0), // Jarak pemisah sebelum kotak pengumuman

            // --- 4. PENGUMUMAN (PRAKTIK EXPANDED) ---
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.yellow[100], // Latar belakang kuning muda
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.orange, width: 1.0),
              ),
              child: Row(
                children: [
                  // Anak ke-1: Ikon Pengumuman
                  Icon(Icons.info_outline, color: Colors.orange, size: 40.0),
                  
                  SizedBox(width: 16.0), // Spasi horizontal antara ikon dan teks
                  
                  // Anak ke-2: Teks Panjang (DIBUNGKUS DENGAN EXPANDED)
                  // Jika Expanded ini dihapus, layar akan memunculkan error garis kuning-hitam (Overflow)
                  Expanded(
                    child: Text(
                      'Pengingat: Seluruh karyawan wajib mengisi form evaluasi kinerja tahunan di HR Portal paling lambat hari Jumat minggu ini.',
                      style: TextStyle(fontSize: 14.0, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.0), // Jarak pemisah

            // --- 5. IKON NOTIFIKASI (PRAKTIK STACK & POSITIONED) ---
            Center( // Kita ketengahkan agar mudah dilihat
              child: Stack(
                // Anak-anak di dalam Stack akan ditumpuk dari indeks 0 (paling bawah) ke indeks terakhir (paling atas)
                children: [
                  
                  // LAPISAN DASAR (Bawah): Ikon Lonceng Besar
                  Icon(
                    Icons.notifications,
                    size: 80.0,
                    color: Colors.grey[400],
                  ),
                  
                  // LAPISAN ATAS: Badge Merah Notifikasi
                  // Kita gunakan Positioned untuk menarik badge ini ke pojok kanan atas lonceng
                  Positioned(
                    right: 0, // Ditarik mentok ke kanan
                    top: 5,   // Ditarik 5 piksel dari atas
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.red, // Warna badge merah
                        shape: BoxShape.circle, // Membentuk kotak menjadi lingkaran sempurna
                        border: Border.all(color: Colors.white, width: 2.0), // Memberi garis tepi putih agar kontras dengan lonceng
                      ),
                      child: Text(
                        '3', // Jumlah notifikasi yang belum dibaca
                        style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}