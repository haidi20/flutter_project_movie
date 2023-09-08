import 'package:core/core.dart';
import 'package:tv_series/data/datasources/db/tv_series_database_helper.dart';
import 'package:tv_series/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<List<TvSeriesTable>> getWatchList();
  Future<List<TvSeriesTable>> getCachedAiringToday();
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<void> cacheAiringToday(List<TvSeriesTable> tvSeriesTable);
  Future<String> insertWatchList(TvSeriesTable tvSeriesTable);
  Future<String> removeWatchlist(TvSeriesTable tvSeriesTable);
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final TvSeriesDatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvSeriesTable>> getWatchList() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<List<TvSeriesTable>> getCachedAiringToday() async {
    final result = await databaseHelper.getCacheTvSeries('airing today');
    if (result.isNotEmpty) {
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
  Future<void> cacheAiringToday(List<TvSeriesTable> tvSeriesTable) async {
    await databaseHelper.clearCache('airing today');
    await databaseHelper.insertCacheTransaction(
      tvSeriesTable,
      'airing today',
    );
  }

  @override
  Future<String> insertWatchList(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tvSeriesTable) async {
    try {
      await databaseHelper.removeWatchlist(tvSeriesTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
