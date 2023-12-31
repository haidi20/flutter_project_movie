import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesSaveWatchList usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = TvSeriesSaveWatchList(mockTvSeriesRepository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
