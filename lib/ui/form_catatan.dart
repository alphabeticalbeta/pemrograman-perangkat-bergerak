import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/db_helper.dart';
import '../models/catatan_model.dart';

class FormCatatan extends StatefulWidget {
  final CatatanModel? catatanLama; // Menampung data jika masuk mode Edit
  
  const FormCatatan({super.key, this.catatanLama});

  @override
  State<FormCatatan> createState() => _FormCatatanState();
}

class _FormCatatanState extends State<FormCatatan> {
  // 0. Kunci untuk Form Validasi
  final _formKey = GlobalKey<FormState>();

  // 1. Variabel Penampung Input
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  
  String _kategoriDipilih = 'Pekerjaan'; // Nilai bawaan Dropdown
  final List<String> _kategoriOptions = ['Pekerjaan', 'Pribadi', 'Belajar'];
  
  String _tanggalDipilih = '';
  String _waktuDipilih = '';
  String _tingkatKesulitan = 'Sedang'; // Nilai bawaan Radio Button
  bool _pengingatHarian = false; // Nilai bawaan Checkbox
  bool _isPrioritas = false;
  double _progres = 0; // Slider di Flutter menggunakan tipe double
  String? _fotoPath; // Path gambar dari ImagePicker

  // 2. Fungsi Persiapan (Berjalan sebelum layar digambar)
  @override
  void initState() {
    super.initState();
    // Jika ada titipan data lama, otomatis isi semua kolom input (Mode Edit)
    if (widget.catatanLama != null) {
      _judulController.text = widget.catatanLama!.judul;
      _deskripsiController.text = widget.catatanLama!.deskripsi;
      _kategoriDipilih = widget.catatanLama!.kategori;
      _tanggalDipilih = widget.catatanLama!.tenggatWaktu;
      _waktuDipilih = widget.catatanLama!.waktuTenggat;
      _tingkatKesulitan = widget.catatanLama!.tingkatKesulitan;
      _pengingatHarian = widget.catatanLama!.pengingatHarian;
      _isPrioritas = widget.catatanLama!.isPrioritas;
      _progres = widget.catatanLama!.progres.toDouble();
      _fotoPath = widget.catatanLama!.fotoPath;
    }
  }

  // 3. Fungsi Pemilih Tanggal (Date Picker)
  Future<void> _pilihTanggal() async {
    final DateTime? tanggalAwal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (tanggalAwal != null) {
      setState(() {
        // Mengubah format tanggal menjadi String YYYY-MM-DD
        _tanggalDipilih = "${tanggalAwal.year}-${tanggalAwal.month.toString().padLeft(2, '0')}-${tanggalAwal.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // 4. Fungsi Pemilih Waktu (Time Picker)
  Future<void> _pilihWaktu() async {
    final TimeOfDay? waktuAwal = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (waktuAwal != null) {
      setState(() {
        // Mengubah format waktu menjadi String HH:mm
        _waktuDipilih = "${waktuAwal.hour.toString().padLeft(2, '0')}:${waktuAwal.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  // 4.5 Fungsi Ambil Foto
  Future<void> _ambilFoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: source);
    
    if (foto != null) {
      setState(() {
        _fotoPath = foto.path;
      });
    }
  }

  // 5. Fungsi Simpan ke SQLite
  Future<void> _simpanData() async {
    // Memicu validasi pada TextFormField di dalam Form
    if (_formKey.currentState!.validate()) {
      // Validasi manual tambahan
      if (_tanggalDipilih.isEmpty || _waktuDipilih.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tanggal dan Waktu wajib dipilih!')),
        );
        return;
      }

      // Membungkus input menjadi Objek Model
      final modelBaru = CatatanModel(
        id: widget.catatanLama?.id,
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        kategori: _kategoriDipilih,
        tenggatWaktu: _tanggalDipilih,
        waktuTenggat: _waktuDipilih,
        tingkatKesulitan: _tingkatKesulitan,
        pengingatHarian: _pengingatHarian,
        isPrioritas: _isPrioritas,
        progres: _progres.toInt(), // Ubah kembali ke integer untuk SQLite
        fotoPath: _fotoPath,
      );

      // Deteksi Mode Simpan atau Update
      if (widget.catatanLama == null) {
        await DbHelper().insertCatatan(modelBaru);
      } else {
        await DbHelper().updateCatatan(modelBaru);
      }

      if (mounted) Navigator.pop(context, true); // Tutup layar dan kirim sinyal sukses
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catatanLama == null ? 'Tambah Tugas' : 'Edit Tugas'),
        backgroundColor: Colors.teal,
      ),
      body: Form( // Menggunakan widget Form untuk validasi
        key: _formKey,
        child: ListView( // Menggunakan ListView agar bisa di-scroll jika layar penuh
          padding: const EdgeInsets.all(16.0),
          children: [
            // Input 1: Teks Dasar dengan Validasi (TextFormField)
            TextFormField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: 'Judul Tugas', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Input 2: Dropdown (Pilihan Kategori)
            DropdownButtonFormField<String>(
              initialValue: _kategoriDipilih,
              decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
              items: _kategoriOptions.map((String val) {
                return DropdownMenuItem(value: val, child: Text(val));
              }).toList(),
              onChanged: (newValue) {
                setState(() => _kategoriDipilih = newValue!);
              },
            ),
            const SizedBox(height: 16),

            // Input 3: Pemilih Tanggal dan Waktu (Berdampingan dengan Row)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pilihTanggal,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Tanggal Tenggat', border: OutlineInputBorder()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_tanggalDipilih.isEmpty ? 'Pilih' : _tanggalDipilih),
                          const Icon(Icons.calendar_today, color: Colors.teal),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: _pilihWaktu,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Waktu Tenggat', border: OutlineInputBorder()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_waktuDipilih.isEmpty ? 'Pilih' : _waktuDipilih),
                          const Icon(Icons.access_time, color: Colors.teal),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Input 4: Segmented Button (Tingkat Kesulitan)
            const Text('Tingkat Kesulitan:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment<String>(value: 'Mudah', label: Text('Mudah')),
                ButtonSegment<String>(value: 'Sedang', label: Text('Sedang')),
                ButtonSegment<String>(value: 'Sulit', label: Text('Sulit')),
              ],
              selected: {_tingkatKesulitan},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() => _tingkatKesulitan = newSelection.first);
              },
            ),
            const Divider(),

            // Input 5: Checkbox (Pengingat Harian)
            CheckboxListTile(
              title: const Text('Aktifkan Pengingat Harian'),
              activeColor: Colors.teal,
              value: _pengingatHarian,
              onChanged: (nilaiBaru) {
                setState(() => _pengingatHarian = nilaiBaru!);
              },
            ),

            // Input 6: Switch (Prioritas Tinggi)
            SwitchListTile(
              title: const Text('Tandai sebagai Prioritas Tinggi', style: TextStyle(fontWeight: FontWeight.bold)),
              activeThumbColor: Colors.red,
              value: _isPrioritas,
              onChanged: (nilaiBaru) {
                setState(() => _isPrioritas = nilaiBaru);
              },
            ),
            const Divider(),

            // Input 7: Slider (Progres Tugas)
            const Text('Persentase Progres:', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _progres,
              min: 0,
              max: 100,
              divisions: 10, // Melompat per 10%
              label: '${_progres.toInt()}%',
              activeColor: Colors.teal,
              onChanged: (nilaiBaru) {
                setState(() => _progres = nilaiBaru);
              },
            ),
            const Divider(),

            // Input 8: Image Picker (Ambil Foto)
            const Text('Foto Lampiran:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Kamera'),
                    onPressed: () => _ambilFoto(ImageSource.camera),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                    onPressed: () => _ambilFoto(ImageSource.gallery),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_fotoPath != null && _fotoPath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                        _fotoPath!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(_fotoPath!),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              )
            else
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Text('Belum ada foto yang dipilih', style: TextStyle(color: Colors.grey)),
                ),
              ),
            
            const SizedBox(height: 24),
            
            // Tombol Simpan
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: _simpanData,
                child: const Text('Simpan Tugas', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}