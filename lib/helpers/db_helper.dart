import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
import '../models/catatan_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = 'catatan_tugas.db';
    late DatabaseFactory factory;
    
    if (kIsWeb) {
      factory = databaseFactoryFfiWeb;
    } else {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        sqfliteFfiInit();
        factory = databaseFactoryFfi;
      } else {
        factory = databaseFactory;
      }
      path = join(await factory.getDatabasesPath(), 'catatan_tugas.db');
    }

    return await factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 3, 
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
  }

  // STRUKTUR TABEL BARU (LEBIH LENGKAP)
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE catatan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        deskripsi TEXT NOT NULL,
        kategori TEXT NOT NULL,
        tenggatWaktu TEXT NOT NULL,
        waktuTenggat TEXT NOT NULL,
        tingkatKesulitan TEXT NOT NULL,
        pengingatHarian INTEGER NOT NULL,
        isPrioritas INTEGER NOT NULL,
        progres INTEGER NOT NULL,
        fotoPath TEXT
      )
    ''');
  }

  // FUNGSI MIGRASI JIKA ADA PERUBAHAN TABEL
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      // Cara termudah untuk modul pemula: Hapus tabel lama dan buat baru
      // PENTING: Cara ini akan menghapus semua data lama!
      await db.execute('DROP TABLE IF EXISTS catatan');
      await _onCreate(db, newVersion);
    }
  }

  // --- FUNGSI CRUD LOKAL ---
  Future<int> insertCatatan(CatatanModel catatan) async {
    final db = await database;
    return await db.insert('catatan', catatan.toMap());
  }

  Future<List<CatatanModel>> getCatatan() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('catatan', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => CatatanModel.fromMap(maps[i]));
  }

  Future<int> updateCatatan(CatatanModel catatan) async {
    final db = await database;
    return await db.update(
      'catatan',
      catatan.toMap(),
      where: 'id = ?',
      whereArgs: [catatan.id],
    );
  }

  Future<int> deleteCatatan(int id) async {
    final db = await database;
    return await db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}