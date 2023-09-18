import 'package:core/core.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockTvSeriesDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockTvSeriesDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('get airing today tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await dataSource.getWatchList();
      // assert
      TvSeriesTable testTvSeriesModel = TvSeriesTable.fromMap(testTvSeriesMap);
      expect(result, [testTvSeriesModel]);
    });
  });

  group('cache airing today tv series', () {
    test('should call database helper to save data', () async {
      // arrange
      TvSeriesTable tvSeriesTableCacheMap =
          TvSeriesTable.fromMap(testTvSeriesCacheMap);
      when(mockDatabaseHelper.clearCache('airing today'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheAiringToday([tvSeriesTableCacheMap]);
      // assert
      verify(mockDatabaseHelper.clearCache('airing today'));
      verify(mockDatabaseHelper
          .insertCacheTransaction([tvSeriesTableCacheMap], 'airing today'));
    });

    test('should return list of tv series from db when data exist', () async {
      // arrange
      TvSeriesTable tvSeriesTableCacheMap =
          TvSeriesTable.fromMap(testTvSeriesCacheMap);
      when(mockDatabaseHelper.getCacheTvSeries('airing today'))
          .thenAnswer((_) async => [testTvSeriesCacheMap]);
      // act
      final result = await dataSource.getCachedAiringToday();
      // assert
      expect(result, [tvSeriesTableCacheMap]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvSeries('airing today'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedAiringToday();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('Get TV Series Detail By Id', () {
    final tId = 1;

    test('should return TV Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesMap);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchList(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchList(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove airing today', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}
