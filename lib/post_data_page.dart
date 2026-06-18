import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostDataPage extends StatefulWidget {
  const PostDataPage({super.key});

  @override
  State<PostDataPage> createState() => _PostDataPageState();
}

class _PostDataPageState extends State<PostDataPage> {
  // 1. Controller untuk menangkap inputan teks
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  
  // 2. Variabel status loading
  bool _isLoading = false;

  // 3. FUNGSI UNTUK MENGIRIM DATA (POST REQUEST)
  Future<void> _kirimPengajuan() async {
    // Validasi sederhana: Jangan kirim jika kosong
    if (_judulController.text.isEmpty || _keteranganController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua kolom!'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      
      // A. Menyiapkan Data yang akan dikirim (Format Map/Kamus Dart)
      final Map<String, dynamic> dataKirim = {
        'title': _judulController.text,
        'body': _keteranganController.text,
        'userId': 1, // Simulasi ID pegawai yang sedang login
      };

      // B. Melakukan POST Request
      final response = await http.post(
        url,
        // Header wajib agar server tahu kita mengirim teks JSON
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // jsonEncode mengubah format Map Dart menjadi teks String JSON utuh
        body: jsonEncode(dataKirim),
      );

      if (!mounted) return;

      // C. Mengecek respons server (201 artinya Created/Berhasil Dibuat)
      if (response.statusCode == 201) {
        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Pengajuan Cuti Berhasil Dikirim!'), backgroundColor: Colors.green),
        );
        // Kosongkan form setelah sukses
        _judulController.clear();
        _keteranganController.clear();
      } else {
        throw Exception('Gagal mengirim data. Status: ${response.statusCode}');
      }
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi Kesalahan: $e'), backgroundColor: Colors.red),
      );
    } finally {
      // finally akan SELALU dieksekusi baik saat sukses maupun gagal (error)
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pengajuan Cuti'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Silakan isi form berikut untuk mengajukan cuti ke HRD.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Kotak Input Judul
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Jenis/Judul Cuti',
                hintText: 'Contoh: Cuti Tahunan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Kotak Input Keterangan
            TextField(
              controller: _keteranganController,
              maxLines: 3, // Membuat kotak teks lebih tinggi
              decoration: const InputDecoration(
                labelText: 'Keterangan / Alasan',
                hintText: 'Jelaskan alasan cuti Anda secara singkat...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            
            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: _isLoading ? null : _kirimPengajuan,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Kirim Pengajuan', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}