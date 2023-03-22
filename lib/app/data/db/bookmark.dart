// Kalau untuk data kecil (data yang sifat nya sedikit dapat menggunakan shared preferances dan get storage)
// Storage digunakan untuk auto login, thema dll

// Kalau data base menggunakan database lokal (SQFLITE, HIVE, moor) - ini db offline
// Kalau databse online seperti firebase + supabase
// Kalau server seperti google cloude dan Amazon Cloud

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  // Buat private constructor
  DatabaseManager._private();

  // Buat instance / jembatannya
  static DatabaseManager instance = DatabaseManager._private();

  // Membuat tempat simpan dengan database
  Database? _db;

  // Ini buat get db yang sebelumnya private constructor
  Future<Database> get db async {
    // Kita anggep _db sudah ada data nya
    _db ??= await _initDb();

    return _db!;
  }

  // InitDb
  Future _initDb() async {
    // Buat directory dulu
    Directory docDir = await getApplicationDocumentsDirectory();

    // Membuat path
    String path = join(docDir.path, 'bookmark.db');

    return await openDatabase(
      path,
      version: 1, //karena baru awal awal maka version 1
      onCreate: (database, version) async {
        // kita mengekesuksi syntak sql
        // ATAAU MEMBUAT SYNTAK SQL NYA DI SQFLITE
        return await database.execute('''
            CREATE TABLE bookmark (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              surah TEXT NOT NULL,
              ayat INTEGER NOT NULL,
              juz INTEGER NOT NULL,
              via TEXT NOT NULL,
              index_ayat INTEGER NOT NULL,
              last_read INTEGER DEFAULT 0
            )
          ''');
      },
    );
  }

  // Digunakan untuk close database nya pas di dispose
  Future closeDb() async {
    _db = await instance.db;
    _db!.close();
  }
}

// PROSES PEMBUATAN DATABASE MANAGER KITA TELAH SELESAI