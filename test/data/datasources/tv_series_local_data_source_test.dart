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
}
