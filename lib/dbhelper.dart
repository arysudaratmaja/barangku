import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'barang.dart';

//pubspec.yml
//kelass Dbhelper
class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'databarang.db';
    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }
  //buat tabel baru dengan nama barang
  void _createDb(Database db, int version) async {
    await db.execute("""
      CREATE TABLE barang (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        kode TEXT,
        harga TEXT
      )
    """);
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('barang', orderBy: 'kode');
    return mapList;
  }
//create databases
  Future<int> insert(Barang object) async {
    Database db = await this.database;
    int count = await db.insert('barang', object.toMap());
    return count;
  }
//update databases
  Future<int> update(Barang object) async {
    Database db = await this.database;
    int count = await db.update('barang', object.toMap(),
        where: 'id=?',
        whereArgs: [object.id]);
    return count;
  }
//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('barang',
        where: 'id=?',
        whereArgs: [id]);
    return count;
  }
  Future<List<Barang>> getBarangList() async {
    var barangMapList = await select();
    int count = barangMapList.length;
    List<Barang> barangList = List<Barang>();
    for (int i=0; i<count; i++) {
      barangList.add(Barang.fromMap(barangMapList[i]));
    }
    return barangList;
  }
}