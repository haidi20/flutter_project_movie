import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchist_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendation,
  GetTvSeriesWatchListStatus,
  GetTvSeriesSeason,
  TvSeriesSaveWatchList,
  TvSeriesRemoveWatchlist,
])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;
  late MockGetTvSeriesWatchListStatus mockGetTvSeriesWatchListStatus;
  late MockGetTvSeriesSeason mockGetTvSeriesSeason;
  late MockTvSeriesSaveWatchList mockTvSeriesSaveWatchList;
  late MockTvSeriesRemoveWatchlist mockTvSeriesRemoveWatchlist;
  late TvSeriesDetailNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    mockGetTvSeriesWatchListStatus = MockGetTvSeriesWatchListStatus();
    mockGetTvSeriesSeason = MockGetTvSeriesSeason();
    mockTvSeriesSaveWatchList = MockTvSeriesSaveWatchList();
    mockTvSeriesRemoveWatchlist = MockTvSeriesRemoveWatchlist();

    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendation: mockGetTvSeriesRecommendation,
      getTvSeriesWatchListStatus: mockGetTvSeriesWatchListStatus,
      getTvSeriesSeason: mockGetTvSeriesSeason,
      tvSeriesSaveWatchList: mockTvSeriesSaveWatchList,
      tvSeriesRemoveWatchlist: mockTvSeriesRemoveWatchlist,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

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

  final tTvSeriesSeason = Season(
    airDate: "1952-12-26",
    episodeCount: 6,
    id: 134441,
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];
  final tTvSeriesSeasonList = <Season>[tTvSeriesSeason];

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendation.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendation.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.isLoading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.isLoaded);
      expect(provider.tvSeriesDetail, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation Tv Series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.isLoaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });
  });

  group('Get Tv Series Seasons', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      verify(mockGetTvSeriesRecommendation.execute(tId));
      expect(provider.tvSeriesSeasons, tTvSeriesSeasonList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.getTvSeriesRecommendationState, RequestState.isLoaded);
      expect(provider.tvSeriesSeasons, tTvSeriesSeasonList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.getTvSeriesRecommendationState, RequestState.isError);
      expect(provider.message, 'Failed');
    });
  });
  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      verify(mockGetTvSeriesRecommendation.execute(tId));
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.getTvSeriesRecommendationState, RequestState.isLoaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.getTvSeriesRecommendationState, RequestState.isError);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvSeriesWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockTvSeriesSaveWatchList.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockTvSeriesSaveWatchList.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockTvSeriesRemoveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvSeriesDetail);
      // assert
      verify(mockTvSeriesRemoveWatchlist.execute(testTvSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockTvSeriesSaveWatchList.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockTvSeriesSaveWatchList.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTvSeriesDetail(id: tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.isError);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
