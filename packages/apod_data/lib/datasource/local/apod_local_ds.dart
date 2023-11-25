import 'dart:async';

import 'package:apod_data/model/apod.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:developer';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ApodLocalDataSource {
  Database? _database;
  StreamController<List<APOD>> apodStream = StreamController<List<APOD>>();

  Future<Database> _init() async {
    // these are specificially needed to support Windows and Linux
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    final database = openDatabase(
      join(await getDatabasesPath(), 'apod_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE apods(date TEXT PRIMARY KEY, title TEXT, url TEXT, explanation TEXT, hdurl TEXT, media_type TEXT)');
      },
      version: 1,
    );
    return database;
  }

  Future<APOD?> getApodByDate(String date) async {
    final List<Map<String, dynamic>> apods = await (await getDataBase())
        .query("apods", where: "date = ?", whereArgs: [date]);

    log("getApodByDate : $apods");
    var result = apods.map((e) => APOD.fromJson(e));
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> saveApod(APOD apod) async {
    (await getDataBase()).insert(
      "apods",
      apod.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _getAllApods();
  }

  Future<void> saveApods(List<APOD> apods) async {
    Batch batch = (await getDataBase()).batch();
    for (var element in apods) {
      batch.insert(
        "apods",
        element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    _getAllApods();
  }

  Future<Database> getDataBase() async {
    _database ??= await _init();
    return _database!;
  }

  Stream<List<APOD>> getAllApods() {
    _getAllApods();
    return apodStream.stream;
  }

  Future<List<APOD>> _getAllApods() async {
    final List<Map<String, dynamic>> apods =
        await (await getDataBase()).rawQuery("SELECT * from apods ORDER BY date DESC");
    var apodsList = apods.map((apod) => APOD.fromJson(apod)).toList();
    apodStream.add(apodsList);
    return apodsList;
  }

  void close() {
    apodStream.close();
  }
}
