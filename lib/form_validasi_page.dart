import 'package:flutter/material.dart';

class FormValidasiPage extends StatefulWidget {
  const FormValidasiPage({super.key});

  @override
  State<FormValidasiPage> createState() => _FormValidasiPageState();
}

class _FormValidasiPageState extends State<FormValidasiPage> {
  // 1. Membuat Kunci Master untuk Form
  final _formKey = GlobalKey<FormState>();
  
  // 2. Controller seperti biasa
  final TextEditingController _namaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validasi Form'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        // 3. WIDGET FORM SEBAGAI PEMBUNGKUS UTAMA
        child: Form(
          key: _formKey, // Memasang kunci master ke Form ini
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // 4. MENGGUNAKAN TextFormField BUKAN TextField BIASA
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap (Wajib Diisi)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                // 5. ATURAN VALIDASI
                validator: (value) {
                  // value berisi teks yang sedang diketik saat ini
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong!'; // Pesan error warna merah
                  }
                  if (value.length < 3) {
                    return 'Nama minimal harus 3 huruf!';
                  }
                  return null; // Mengembalikan null berarti data VALID (lolos tes)
                },
              ),
              
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: () {
                    // 6. MENGEKSEKUSI PEMERIKSAAN (VALIDASI) SERENTAK
                    if (_formKey.currentState!.validate()) {
                      // Jika validate() menghasilkan nilai true (semua lolos tes)
                      String namaValid = _namaController.text;
                      
                      // Memunculkan notifikasi sukses (Snackbar) di bawah layar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Memproses data Bapak/Ibu $namaValid...')),
                      );
                    } else {
                      // Jika validate() menghasilkan false (ada yang gagal tes)
                      debugPrint('Formulir ditolak. Ada data yang salah.');
                    }
                  },
                  child: const Text(
                    'Kirim Formulir', 
                    style: TextStyle(color: Colors.white, fontSize: 16)
                  ),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}