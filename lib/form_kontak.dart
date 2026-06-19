import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormKontak extends StatefulWidget {
  // 1. TAMBAHAN BARU: Variabel opsional untuk menampung data lama
  final Map<String, dynamic>? dataLama;
  
  // Parameter dataLama dibuat opsional (boleh null)
  const FormKontak({super.key, this.dataLama});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  // 2. TAMBAHAN BARU: Mengisi form otomatis JIKA ada data lama
  @override
  void initState() {
    super.initState();
    // Mengecek apakah parameter dataLama dari halaman sebelumnya ada isinya?
    if (widget.dataLama != null) {
      _nameController.text = widget.dataLama!['name'];
      _emailController.text = widget.dataLama!['email'];
    }
  }

  // 3. LOGIKA SIMPAN (Gabungan POST dan PUT)
  Future<void> _simpanKontak() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan Email tidak boleh kosong!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Cek status: Apakah ini update atau tambah baru?
      final isUpdate = widget.dataLama != null;
      
      // Jika Update, URL butuh ID. Jika Tambah, URL standar.
      final url = isUpdate
          ? Uri.parse('https://jsonplaceholder.typicode.com/users/${widget.dataLama!['id']}')
          : Uri.parse('https://jsonplaceholder.typicode.com/users');

      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final bodyData = jsonEncode({
        'name': _nameController.text,
        'email': _emailController.text,
      });

      // Jika Update gunakan http.put, jika Tambah gunakan http.post
      final response = isUpdate
          ? await http.put(url, headers: headers, body: bodyData)
          : await http.post(url, headers: headers, body: bodyData);

      // Status 200 (OK/Update Sukses) atau 201 (Created Sukses)
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dataHasil = jsonDecode(response.body);
        if (!mounted) return;
        Navigator.pop(context, dataHasil); // Bawa pulang data baru/edit
      } else {
        throw Exception('Gagal menyimpan data');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ubah judul AppBar secara dinamis
    final judulApp = widget.dataLama != null ? 'Edit Kontak' : 'Tambah Kontak Baru';

    return Scaffold(
      appBar: AppBar(title: Text(judulApp), backgroundColor: Colors.indigo),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Alamat Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                onPressed: _isLoading ? null : _simpanKontak,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Data', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}