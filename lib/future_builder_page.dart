import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Kita menggunakan StatefulWidget agar bisa menyimpan Future di initState
class FutureBuilderPage extends StatefulWidget {
  const FutureBuilderPage({super.key});

  @override
  State<FutureBuilderPage> createState() => _FutureBuilderPageState();
}

class _FutureBuilderPageState extends State<FutureBuilderPage> {
  // 1. Variabel penampung fungsi Future (Bukan penampung datanya)
  late Future<List<dynamic>> _dataPegawaiFuture;

  // 2. FUNGSI PENARIK DATA (Hanya mengembalikan data, TANPA setState)
  Future<List<dynamic>> _tarikDataPegawai() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Jika sukses, kembalikan List hasil terjemahan JSON
      return jsonDecode(response.body);
    } else {
      // Jika gagal, lemparkan error
      throw Exception('Gagal menghubungi server API');
    }
  }

  // 3. Menjalankan penarikan data TEPAT SAAT halaman pertama kali dibuka
  @override
  void initState() {
    super.initState();
    _dataPegawaiFuture = _tarikDataPegawai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pegawai (FutureBuilder)'),
        backgroundColor: Colors.teal,
      ),
      
      // 4. MENGGUNAKAN FUTUREBUILDER SEBAGAI BODY UTAMA
      body: FutureBuilder<List<dynamic>>(
        future: _dataPegawaiFuture, // Menyambungkan FutureBuilder ke fungsi penarik data
        builder: (context, snapshot) {
          
          // KONDISI 1: Sedang menunggu data (Loading)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 16),
                  Text('Mengunduh data pegawai...'),
                ],
              ),
            );
          }
          
          // KONDISI 2: Terjadi Error (Misal tidak ada internet)
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          
          // KONDISI 3: Data sukses ditarik dan tidak kosong
          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Kita memindahkan data dari snapshot ke variabel lokal
            final listPegawai = snapshot.data!;
            
            return ListView.builder(
              itemCount: listPegawai.length,
              itemBuilder: (context, index) {
                final pegawai = listPegawai[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(pegawai['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(pegawai['company']['name']), // Mengambil JSON bersarang (Nested)
                );
              },
            );
          }
          
          // KONDISI 4: Data sukses ditarik, tapi server mengirim daftar kosong
          else {
            return const Center(child: Text('Tidak ada data pegawai.'));
          }
          
        },
      ),
    );
  }
}