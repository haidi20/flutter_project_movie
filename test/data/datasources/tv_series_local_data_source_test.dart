import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('get airing today tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getAiringTodayTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await dataSource.getAiringTodayTvSeries();
      // assert
      TvSeriesTable testTvSeriesModel = TvSeriesTable.fromMap(testTvSeriesMap);
      expect(result, [testTvSeriesModel]);
    });
  });

  group('cache airing today tv series', () {
    test('should call database helper to save data tv series', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTvSeries('airing today'))
          .thenAnswer((_) async => 1);
      // act
      TvSeriesTable tvSeriesTableCacheMap =
          TvSeriesTable.fromMap(testTvSeriesCacheMap);
      await dataSource.cacheAiringTodayTvSeries([tvSeriesTableCacheMap]);
      // assert
      verify(mockDatabaseHelper.clearCacheTvSeries('airing today'));
      verify(mockDatabaseHelper.insertCacheTransactionTvSeries(
          [tvSeriesTableCacheMap], 'airing today'));
    });

    test('should return list of tv series from db when data exist', () async {
      // arrange
      TvSeriesTable tvSeriesTableCacheMap =
          TvSeriesTable.fromMap(testTvSeriesCacheMap);
      when(mockDatabaseHelper.getCacheTvSeries('airing today'))
          .thenAnswer((_) async => [testTvSeriesCacheMap]);
      // act
      final result = await dataSource.getCachedAiringTodayTvSeries();
      // assert
      expect(result, [tvSeriesTableCacheMap]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvSeries('airing today'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedAiringTodayTvSeries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
