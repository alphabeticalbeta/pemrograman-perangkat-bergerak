import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/catatan_model.dart';
import 'form_catatan.dart';

class HalamanCatatan extends StatefulWidget {
  const HalamanCatatan({super.key});

  @override
  State<HalamanCatatan> createState() => _HalamanCatatanState();
}

class _HalamanCatatanState extends State<HalamanCatatan> {
  List<CatatanModel> _daftarCatatan = [];
  bool _isLoading = false;

  Future<void> _refreshCatatan() async {
    setState(() => _isLoading = true);
    final data = await DbHelper().getCatatan();
    setState(() {
      _daftarCatatan = data;
      _isLoading = false;
    });
  }

  // FUNGSI BARU: Memunculkan Jendela Peringatan Hapus
  Future<void> _dialogHapus(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus catatan ini secara permanen?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup dialog jika batal
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                // 1. Eksekusi hapus di database
                await DbHelper().deleteCatatan(id);
                // MENGGUNAKAN context.mounted (Bukan mounted saja) 
                // Karena kita menggunakan context dari builder sesudah await
                if (!context.mounted) return;

                // 2. Tutup kotak dialog
                Navigator.pop(context);

                // 3. Tarik ulang data terbaru untuk memperbarui layar
                _refreshCatatan();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🗑️ Catatan berhasil dihapus')),
                );
              },
              child: const Text(
                'Ya, Hapus',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshCatatan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List Pekerjaan'), backgroundColor: Colors.teal),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _daftarCatatan.isEmpty
              ? const Center(child: Text('Belum ada catatan. Tekan + untuk menambah.'))
              : ListView.builder(
                  itemCount: _daftarCatatan.length,
                  itemBuilder: (context, index) {
                    final catatan = _daftarCatatan[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: (catatan.fotoPath != null && catatan.fotoPath!.isNotEmpty)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: kIsWeb
                                    ? Image.network(
                                        catatan.fotoPath!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(catatan.fotoPath!),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.teal[100],
                                child: Text(catatan.id.toString()),
                              ),
                        title: Text(catatan.judul, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(catatan.deskripsi),
                        
                        // --- INTERAKSI BARU: KLIK UNTUK EDIT ---
                        onTap: () async {
                          // Buka FormCatatan sambil "melempar" objek catatan lama
                          final hasil = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormCatatan(catatanLama: catatan),
                            ),
                          );
                          // Jika proses edit sukses, refresh layar
                          if (hasil == true) _refreshCatatan();
                        },
                        
                        // --- INTERAKSI BARU: TOMBOL HAPUS ---
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Panggil dialog dengan mengirimkan ID unik catatan
                            _dialogHapus(catatan.id!);
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final hasil = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormCatatan()),
          );
          if (!mounted) return;
          if (hasil == true) _refreshCatatan();
        },
      ),
    );
  }
}
