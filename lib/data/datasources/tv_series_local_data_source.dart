import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<List<TvSeriesTable>> getAiringTodayTvSeries();
  Future<String> insertAiringToday(TvSeriesTable tvSeriesTable);
  Future<List<TvSeriesTable>> getCachedAiringTodayTvSeries();
  Future<void> cacheAiringTodayTvSeries(List<TvSeriesTable> tvSeriesTable);
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvSeriesTable>> getAiringTodayTvSeries() async {
    final result = await databaseHelper.getAiringTodayTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertAiringToday(TvSeriesTable TvSeries) async {
    try {
      await databaseHelper.insertAiringTodayTvSeries(TvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getCachedAiringTodayTvSeries() async {
    final result = await databaseHelper.getCacheMovies('airing today');
    if (result.length > 0) {
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheAiringTodayTvSeries(List<TvSeriesTable> TvSeries) async {
    await databaseHelper.clearCache('airing today');
    await databaseHelper.insertCacheTransactionTvSeries(
      TvSeries,
      'airing today',
    );
  }
}
