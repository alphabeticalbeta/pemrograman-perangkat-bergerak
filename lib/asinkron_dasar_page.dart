import 'package:flutter/material.dart';

class AsinkronDasarPage extends StatefulWidget {
  const AsinkronDasarPage({super.key});

  @override
  State<AsinkronDasarPage> createState() => _AsinkronDasarPageState();
}

class _AsinkronDasarPageState extends State<AsinkronDasarPage> {
  // 1. Variabel penanda status: Apakah aplikasi sedang memuat data?
  bool _isLoading = false;
  
  // 2. Variabel untuk menampung teks hasil
  String _hasilData = "Belum ada data yang ditarik.";

  // 3. FUNGSI ASINKRON (Wajib ditandai dengan kata kunci 'async')
  Future<void> _tarikDataDariServer() async {
    // Langkah A: Ubah status menjadi loading dan perbarui layar (UI)
    setState(() {
      _isLoading = true;
      _hasilData = "Sedang menghubungi server...";
    });

    // Langkah B: Simulasi proses menunggu balasan server internet selama 3 Detik.
    // Kata kunci 'await' membuat program menunggu di baris ini tanpa membuat layar freeze.
    await Future.delayed(const Duration(seconds: 3));

    // Langkah C: Setelah 3 detik berlalu, matikan status loading dan tampilkan hasil
    setState(() {
      _isLoading = false;
      _hasilData = "✅ Berhasil! Data dari server telah ditarik.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Asinkron'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // Menampilkan animasi loading (roda berputar) HANYA JIKA _isLoading bernilai true
              if (_isLoading) 
                const CircularProgressIndicator(color: Colors.deepPurple)
              else 
                const Icon(Icons.cloud_done, size: 80, color: Colors.green),
                
              const SizedBox(height: 30),
              
              // Menampilkan teks status
              Text(
                _hasilData,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 40),
              
              // Tombol untuk memicu penarikan data
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                // Cegah tombol diklik (di-set null) jika sedang loading
                onPressed: _isLoading ? null : _tarikDataDariServer,
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  'Mulai Tarik Data', 
                  style: TextStyle(color: Colors.white, fontSize: 16)
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}