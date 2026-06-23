class CatatanModel {
  int? id;
  String judul;
  String deskripsi;
  String kategori;       // Dari Dropdown (Pekerjaan, Pribadi, Belajar)
  String tenggatWaktu;   // Dari DatePicker (Format: YYYY-MM-DD)
  String waktuTenggat;   // Dari TimePicker (Format: HH:mm)
  String tingkatKesulitan; // Dari Radio Button (Mudah, Sedang, Sulit)
  bool pengingatHarian;  // Dari Checkbox (True/False)
  bool isPrioritas;      // Dari Switch/Checkbox (True/False)
  int progres;           // Dari Slider (0 - 100)
  String? fotoPath;      // Dari ImagePicker (Path lokal)

  // Constructor
  CatatanModel({
    this.id,
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.tenggatWaktu,
    required this.waktuTenggat,
    required this.tingkatKesulitan,
    required this.pengingatHarian,
    required this.isPrioritas,
    required this.progres,
    this.fotoPath,
  });

  // FUNGSI 1: Menerjemahkan Objek Dart menjadi format Map untuk SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'tenggatWaktu': tenggatWaktu,
      'waktuTenggat': waktuTenggat,
      'tingkatKesulitan': tingkatKesulitan,
      'pengingatHarian': pengingatHarian ? 1 : 0,
      // TRIK SQLITE: Ubah tipe Boolean (True/False) menjadi Integer (1/0)
      'isPrioritas': isPrioritas ? 1 : 0, 
      'progres': progres,
      'fotoPath': fotoPath,
    };
  }

  // FUNGSI 2: Menerjemahkan Map dari SQLite kembali menjadi Objek Dart
  factory CatatanModel.fromMap(Map<String, dynamic> map) {
    return CatatanModel(
      id: map['id'],
      judul: map['judul'],
      deskripsi: map['deskripsi'],
      kategori: map['kategori'],
      tenggatWaktu: map['tenggatWaktu'],
      waktuTenggat: map['waktuTenggat'] ?? '00:00',
      tingkatKesulitan: map['tingkatKesulitan'] ?? 'Sedang',
      pengingatHarian: map['pengingatHarian'] == 1,
      // TRIK SQLITE: Kembalikan Integer (1/0) menjadi Boolean (True/False)
      isPrioritas: map['isPrioritas'] == 1, 
      progres: map['progres'] ?? 0,
      fotoPath: map['fotoPath'],
    );
  }
}