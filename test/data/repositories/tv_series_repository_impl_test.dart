import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/data/models/episod_to_air_model.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/network_model.dart';
import 'package:core/data/models/product_company_model.dart';
import 'package:core/data/models/product_country_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/spoken_language_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
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

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Airing Today Tv Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAiringToday()).thenAnswer((_) async => []);
      // act
      await repository.getAiringToday();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringToday())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getAiringToday();
        // assert
        verify(mockRemoteDataSource.getAiringToday());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringToday())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        await repository.getAiringToday();
        // assert
        verify(mockRemoteDataSource.getAiringToday());
        verify(mockLocalDataSource.cacheAiringToday([testTvSeriesCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringToday())
            .thenThrow(ServerException());
        // act
        final result = await repository.getAiringToday();
        // assert
        verify(mockRemoteDataSource.getAiringToday());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
  });

  group('Now popular Tv Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopular();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular()).thenThrow(ServerException());
      // act
      final result = await repository.getPopular();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopular();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Now top rated Tv Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRated();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRated();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRated();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data Tv Series list when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendation(id: tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getTvSeriesRecommendation(id: tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendation(id: tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendation(id: tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendation(id: tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeriesRecommendation(id: tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendation(id: tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendation(id: tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendation(id: tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get tv series Detail', () {
    final tId = 1;
    final testTvSeriesDetailResponse = TvSeriesDetailModel(
      adult: false,
      backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
      createdBy: [],
      episodeRunTime: [15],
      firstAirDate: "1952-12-26",
      genres: [
        GenreModel(
          id: 10763,
          name: "News",
        ),
      ],
      homepage: "https://www.tagesschau.de/",
      id: 94722,
      inProduction: true,
      languages: ["de"],
      lastAirDate: "2023-08-22",
      lastEpisodeToAir: EpisodeToAirModel(
        id: 4533092,
        name: "Episode 234",
        overview: "",
        voteAverage: 0.0,
        voteCount: 0,
        airDate: "2023-08-22",
        episodeNumber: 234,
        episodeType: "standard",
        productionCode: "",
        runtime: 15,
        seasonNumber: 72,
        showId: 94722,
        stillPath: null,
      ),
      name: "Tagesschau",
      nextEpisodeToAir: EpisodeToAirModel(
        id: 4533093,
        name: "Episode 235",
        overview: "",
        voteAverage: 0.0,
        voteCount: 0,
        airDate: "2023-08-23",
        episodeNumber: 235,
        episodeType: "standard",
        productionCode: "",
        runtime: 15,
        seasonNumber: 72,
        showId: 94722,
        stillPath: null,
      ),
      networks: [
        NetworksModel(
          id: 308,
          logoPath: "/fc0O0mvjl8PbHgZXXY2VgPYos1Z.png",
          name: "ARD",
          originCountry: "DE",
        ),
      ],
      numberOfEpisodes: 20839,
      numberOfSeasons: 72,
      originCountry: ["DE"],
      originalLanguage: "de",
      originalName: "Tagesschau",
      overview:
          "German daily news program, the oldest still existing program on German television.",
      popularity: 5104.121,
      posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
      productionCompanies: [
        ProductCompanyModel(
          id: 7201,
          logoPath: "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
          name: "NDR",
          originCountry: "DE",
        ),
      ],
      productionCountries: [
        ProductionCountryModel(
          iso31661: "DE",
          name: "Germany",
        ),
      ],
      seasons: [
        SeasonModel(
          airDate: "1952-12-26",
          episodeCount: 6,
          id: 134441,
          name: "Season 1952",
          overview: "",
          posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
          seasonNumber: 1,
          voteAverage: 3.5,
        ),
      ],
      spokenLanguages: [
        SpokenLanguageModel(
          englishName: "German",
          iso6391: "de",
          name: "Deutsch",
        ),
      ],
      status: "Returning Series",
      tagline: "",
      type: "News",
      voteAverage: 7.531,
      voteCount: 127,
    );

    test(
        'should return tv series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(id: tId))
          .thenAnswer((_) async => testTvSeriesDetailResponse);
      // act
      final result = await repository.getTvSeriesDetail(id: tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(id: tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(id: tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(id: tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(id: tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(id: tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(id: tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(id: tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'Tagesschau';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchList(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchList(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of tv series', () async {
      // arrange
      when(mockLocalDataSource.getWatchList())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchList();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testeTvSeriesWatchList]);
    });
  });
}
