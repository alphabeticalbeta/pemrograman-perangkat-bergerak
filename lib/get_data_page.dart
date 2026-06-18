import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Wajib di-import untuk mengakses internet
import 'dart:convert'; // Wajib di-import untuk menggunakan fungsi jsonDecode()

class GetDataPage extends StatefulWidget {
  const GetDataPage({super.key});

  @override
  State<GetDataPage> createState() => _GetDataPageState();
}

class _GetDataPageState extends State<GetDataPage> {
  // 1. Variabel penampung data JSON yang sudah diterjemahkan
  List<dynamic> _daftarPegawai = [];
  
  // 2. Variabel status loading
  bool _isLoading = false;

  // 3. FUNGSI UNTUK MENARIK DATA DARI API (GET REQUEST)
  Future<void> _tarikDataPegawai() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // A. Menentukan alamat URL (Endpoint)
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

      // B. Melakukan ketukan (Request) ke server dan menunggu balasannya
      final response = await http.get(url);

      // C. Mengecek apakah balasan server adalah 200 (Sukses)
      if (response.statusCode == 200) {
        // D. Menerjemahkan Teks JSON utuh menjadi List agar dikenali Dart
        final List<dynamic> dataJson = jsonDecode(response.body);

        // E. Memperbarui layar dengan data yang baru
        setState(() {
          _daftarPegawai = dataJson; 
          _isLoading = false;
        });
      } else {
        // Jika gagal (Misal: error 404 atau 500)
        throw Exception('Gagal menarik data. Kode Status: ${response.statusCode}');
      }
    } catch (e) {
      // Menangkap error jika internet putus atau URL salah
      setState(() {
        _isLoading = false;
      });
      debugPrint('Terjadi Kesalahan Jaringan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pegawai (Online)'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Bagian Atas: Tombol Pemicu
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: _isLoading ? null : _tarikDataPegawai,
              icon: _isLoading 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.cloud_download, color: Colors.white),
              label: Text(
                _isLoading ? 'Menghubungi Server...' : 'Tarik Data Pegawai',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          
          const Divider(thickness: 2),

          // Bagian Bawah: Menampilkan Data menggunakan ListView.builder
          // Expanded berfungsi agar ListView memakan sisa ruang kosong di bawah tombol
          Expanded(
            child: _daftarPegawai.isEmpty
                ? const Center(child: Text('Data belum ditarik dari server.'))
                : ListView.builder(
                    itemCount: _daftarPegawai.length,
                    itemBuilder: (context, index) {
                      // Mengambil spesifik 1 data pegawai dari senarai
                      final pegawai = _daftarPegawai[index];
                      
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Text(pegawai['id'].toString()), // Membaca Kunci "id" dari JSON
                        ),
                        title: Text(
                          pegawai['name'], // Membaca Kunci "name" dari JSON
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(pegawai['email']), // Membaca Kunci "email" dari JSON
                        trailing: const Icon(Icons.chevron_right),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}