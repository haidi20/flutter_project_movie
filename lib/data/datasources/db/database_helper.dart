import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblCache = 'cache';

  static const String _tblWatchlistTvSeries = 'watch_list_tv_series';
  static const String _tblCacheTvSeries = 'cache_tv_seris';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

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
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvSeries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheTvSeries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<void> insertCacheTransaction(
      List<MovieTable> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCache, movieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
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

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
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

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  // start tv series

  Future<List<Map<String, dynamic>>> getWatchListTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTvSeries);

    return results;
  }

  Future<List<Map<String, dynamic>>> getCacheTvSeries(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheTvSeries,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheTvSeries(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheTvSeries,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<int> insertWatchListTvSeries(TvSeriesTable tvSeriesTable) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvSeries, tvSeriesTable.toJson());
  }

  Future<void> insertCacheTransactionTvSeries(
      List<TvSeriesTable> tvSeriesTable, String category) async {
    final db = await database;

    db!.transaction((txn) async {
      for (final data in tvSeriesTable) {
        final dataJson = data.toJson();
        dataJson['category'] = category;
        txn.insert(_tblCacheTvSeries, dataJson);
      }
    });
  }

  Future<int> removeWatchListTvSeries(TvSeriesTable tvSeriesTable) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [tvSeriesTable.id],
    );
  }

  // end tv series
}
