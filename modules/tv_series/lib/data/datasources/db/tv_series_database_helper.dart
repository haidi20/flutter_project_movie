import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tv_series/data/models/tv_series_table.dart';

class TvSeriesDatabaseHelper {
  static TvSeriesDatabaseHelper? _databaseHelper;
  TvSeriesDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvSeriesDatabaseHelper() =>
      _databaseHelper ?? TvSeriesDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist_tvseries';
  static const String _tblCache = 'cache_tvseries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/db_tvseries.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<void> insertCacheTransaction(
      List<TvSeriesTable> tvseries, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final data in tvseries) {
        final tvSeriesJson = data.toJson();
        tvSeriesJson['category'] = category;
        txn.insert(_tblCache, tvSeriesJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTvSeries(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlist(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, tvSeries.toJson());
  }

  Future<int> removeWatchlist(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
