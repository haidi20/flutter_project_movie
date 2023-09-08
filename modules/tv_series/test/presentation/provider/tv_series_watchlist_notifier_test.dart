import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist.dart';
import 'package:tv_series/presentation/provider/tv_series_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesWatchList])
void main() {
  late TvSeriesWatchListNotifier provider;
  late MockGetTvSeriesWatchList mockGetTvSeriesWatchList;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesWatchList = MockGetTvSeriesWatchList();
    provider = TvSeriesWatchListNotifier(
      getTvseriesWatchlist: mockGetTvSeriesWatchList,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvSeriesWatchList.execute())
        .thenAnswer((_) async => Right([testeTvSeriesWatchList]));
    // act
    await provider.fetchWatchlistTvSeries();
    // assert
    expect(provider.watchlistState, RequestState.isLoaded);
    expect(provider.watchlistTvSeries, [testeTvSeriesWatchList]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeriesWatchList.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvSeries();
    // assert
    expect(provider.watchlistState, RequestState.isError);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
