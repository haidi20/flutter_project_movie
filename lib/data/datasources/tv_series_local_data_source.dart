import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
  Future<String> insertWatchlist(TvSeriesTable tvSeriesTable);
  Future<void> cacheNowPlayingTvSeries(List<TvSeriesTable> tvSeriesTable);
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvSeriesTable TvSeries) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(TvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheNowPlayingTvSeries(List<TvSeriesTable> TvSeries) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransactionTvSeries(
      TvSeries,
      'airing today',
    );
  }
}
