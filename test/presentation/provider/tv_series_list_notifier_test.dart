import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_airing_today_notifier_test.mocks.dart';
import 'tv_series_popular_notifier_test.mocks.dart';
import 'tv_series_top_rated_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesAiringToday mockGetTvSeriesAiringToday;
  late MockGetTvSeriesTopRated mockGetTvSeriesTopRated;
  late MockGetTvSeriesPopular mockGetTvSeriesPopular;
  late TvSeriesListNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesAiringToday = MockGetTvSeriesAiringToday();
    mockGetTvSeriesTopRated = MockGetTvSeriesTopRated();
    mockGetTvSeriesPopular = MockGetTvSeriesPopular();
    provider = TvSeriesListNotifier(
      getTvSeriesAiringToday: mockGetTvSeriesAiringToday,
      getTvSeriesPopular: mockGetTvSeriesPopular,
      getTvSeriesTopRated: mockGetTvSeriesTopRated,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = TvSeries(
    id: 94722,
    name: "Tagesschau",
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    backdropPath: 'path/to/backdrop.jpg',
    firstAirDate: '2023-08-23',
    genreIds: [1, 2, 3],
    originCountry: ['US', 'UK'],
    originalLanguage: 'English',
    originalName: 'Original Name',
    popularity: 7.8,
    voteAverage: 7.5,
    voteCount: 1000,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Airing Today Tv Series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.isEmpty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchWatchListTvSeries();
      // assert
      verify(mockGetTvSeriesAiringToday.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchWatchListTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.isLoading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchWatchListTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.isLoaded);
      expect(provider.airingTodayTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchWatchListTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.isError);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular Tv Series', () {
    test('initialState should be Empty', () {
      expect(provider.popularState, equals(RequestState.isEmpty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvSeriesPopular.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      verify(mockGetTvSeriesPopular.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvSeriesPopular.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularState, RequestState.isLoading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTvSeriesPopular.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularState, RequestState.isLoaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularState, RequestState.isError);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top Rated Tv Series', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedState, equals(RequestState.isEmpty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvSeriesTopRated.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      verify(mockGetTvSeriesTopRated.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvSeriesTopRated.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedState, RequestState.isLoading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTvSeriesTopRated.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedState, RequestState.isLoaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedState, RequestState.isError);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
