import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'form_kontak.dart'; // Kita akan buat file ini di langkah selanjutnya

class HalamanKontak extends StatefulWidget {
  const HalamanKontak({super.key});

  @override
  State<HalamanKontak> createState() => _HalamanKontakState();
}

class _HalamanKontakState extends State<HalamanKontak> {
  // 1. Variabel penampung data dan status
  List<dynamic> _daftarKontak = [];
  bool _isLoading = false;

  // 2. Fungsi READ: Menarik data dari API
  Future<void> fetchKontak() async {
    setState(() {
      _isLoading = true; // Nyalakan animasi loading saat fungsi mulai berjalan
    });

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      
      if (response.statusCode == 200) {
        setState(() {
          _daftarKontak = jsonDecode(response.body);
        });
      } else {
        _tampilkanPesan('Gagal mengambil data. Kode: ${response.statusCode}');
      }
    } catch (e) {
      _tampilkanPesan('Terjadi kesalahan jaringan: $e');
    } finally {
      setState(() {
        _isLoading = false; // Matikan loading apa pun yang terjadi (sukses/gagal)
      });
    }
  }

  // --- FUNGSI BARU 1: Menjalankan HTTP DELETE ---
  Future<void> _hapusKontak(int id) async {
    setState(() {
      _isLoading = true; // Munculkan loading saat mulai menghapus
    });

    try {
      // Perhatikan penyisipan variabel '$id' di akhir URL!
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users/$id');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        _tampilkanPesan('✅ Kontak berhasil dihapus!');
        
        // Hapus data dari memori lokal (Karena kita pakai Fake API)
        setState(() {
          _daftarKontak.removeWhere((item) => item['id'] == id);
        });
        
        // CATATAN: Jika menggunakan Server Asli, kode di atas diganti dengan:
        // fetchKontak(); 
      } else {
        _tampilkanPesan('Gagal menghapus data. Kode: ${response.statusCode}');
      }
    } catch (e) {
      _tampilkanPesan('Terjadi kesalahan jaringan: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- FUNGSI BARU 2: Memunculkan Jendela Konfirmasi ---
  void _tampilkanDialogHapus(int id, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data "$nama"? Tindakan ini tidak dapat dibatalkan.'),
          actions: [
            // Tombol Batal
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog tanpa melakukan apa-apa
              },
              child: const Text('Batal'),
            ),
            // Tombol Hapus (Warna Merah)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context); // 1. Tutup dialognya dulu
                _hapusKontak(id);       // 2. Baru jalankan perintah hapus ke server
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 3. Fungsi pembantu untuk memunculkan Snackbar (Pesan konfirmasi)
  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  // 4. Otomatis menarik data saat halaman pertama kali dibuka
  @override
  void initState() {
    super.initState();
    fetchKontak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Kontak'),
        backgroundColor: Colors.indigo,
        actions: [
          // Tombol Refresh manual di pojok kanan atas AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchKontak,
          )
        ],
      ),
      
      // 5. AREA BODY: Menampilkan Loading atau ListView
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _daftarKontak.isEmpty
              ? const Center(child: Text('Tidak ada data kontak.'))
              : ListView.builder(
                  itemCount: _daftarKontak.length,
                  itemBuilder: (context, index) {
                    final kontak = _daftarKontak[index];
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo[100],
                          child: Text(kontak['id'].toString()),
                        ),
                        title: Text(kontak['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(kontak['email']),
                        
                        // 6. AREA TRAILING: Tempat diletakkannya ikon Edit & Hapus
                        trailing: Row(
                          // WAJIB ADA: Mencegah error layout (overflow)
                          mainAxisSize: MainAxisSize.min, 
                          children: [
                            // Tombol Edit (UPDATE)
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                // Buka FormKontak dan kirimkan data kontak saat ini
                                final dataUpdate = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormKontak(dataLama: kontak), 
                                  ),
                                );

                                // Jika sukses di-edit dan membawa pulang data baru
                                if (dataUpdate != null) {
                                  setState(() {
                                    // Cari urutan (index) data lama di dalam List
                                    int index = _daftarKontak.indexWhere((item) => item['id'] == dataUpdate['id']);
                                    if (index != -1) {
                                      // Timpa baris lama tersebut dengan wujud data yang baru
                                      _daftarKontak[index] = dataUpdate;
                                    }
                                  });
                                  _tampilkanPesan('✅ Data berhasil diperbarui!');
                                }
                              },
                            ),
                            // Tombol Hapus (DELETE)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Panggil dialog konfirmasi, operasikan ID dan Nama kontaknya
                                _tampilkanDialogHapus(kontak['id'], kontak['name']);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
      // 7. AREA FLOATING BUTTON: Pintu untuk aksi CREATE
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          // 1. Pindah ke Halaman Form dan TUNGGU (await) sampai form tertutup
          final kontakBaru = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormKontak()),
          );

          // 2. Jika form ditutup dengan membawa data (bukan karena tombol 'Back' fisik)
          if (kontakBaru != null) {
            // Masukkan data baru tersebut ke dalam List antarmuka lokal kita
            setState(() {
              _daftarKontak.add(kontakBaru);
            });
            _tampilkanPesan('✅ Berhasil menambahkan ${kontakBaru['name']}');
            
            // CATATAN: Jika menggunakan Server Asli, kode setState di atas tidak perlu.
            // Anda cukup memanggil fungsi: fetchKontak();
          }
        },
      ),
    );
  }
}