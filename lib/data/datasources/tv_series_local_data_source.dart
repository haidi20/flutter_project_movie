import 'package:core/core.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<List<TvSeriesTable>> getWatchList();
  Future<List<TvSeriesTable>> getCachedAiringToday();
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<void> cacheAiringToday(List<TvSeriesTable> tvSeriesTable);
  Future<String> insertWatchList(TvSeriesTable tvSeriesTable);
  Future<String> removeWatchlist(TvSeriesTable tvSeriesTable);
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvSeriesTable>> getWatchList() async {
    final result = await databaseHelper.getWatchListTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<List<TvSeriesTable>> getCachedAiringToday() async {
    final result = await databaseHelper.getCacheTvSeries('airing today');
    if (result.length > 0) {
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<void> cacheAiringToday(List<TvSeriesTable> TvSeriesTable) async {
    await databaseHelper.clearCacheTvSeries('airing today');
    await databaseHelper.insertCacheTransactionTvSeries(
      TvSeriesTable,
      'airing today',
    );
  }

  @override
  Future<String> insertWatchList(TvSeriesTable TvSeries) async {
    try {
      await databaseHelper.insertWatchListTvSeries(TvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tvSeriesTable) async {
    try {
      await databaseHelper.removeWatchListTvSeries(tvSeriesTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
