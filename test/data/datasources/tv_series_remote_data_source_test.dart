import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/datasources/api/api_helper.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../json_reader.dart';

class MockApiHelper extends Mock implements ApiHelper {}

void main() {
  const apiKey = 'api_key=bfc228e757fb368b3ddd4bb9609def19';
  const baseUrl = 'https://api.themoviedb.org/3';

  late MockApiHelper mockApiHelper;
  late TvSeriesRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiHelper = MockApiHelper();
    dataSource = TvSeriesRemoteDataSourceImpl(apiHelper: mockApiHelper);
  });

  group('get Airing Today Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_airing_today.json')))
        .tvSeriesList;

    test('should return list of Tv Series Model when the response code is 200',
        () async {
      // arrange
      // fungsi when tidak mau bekerja
      // hasil dari act selalu dari API, bukan data dummy
      when(() =>
              mockApiHelper.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_airing_today.json'), 200));
      // act
      final result = await dataSource.getAiringToday();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      // fungsi when tidak mau bekerja
      // hasil dari act selalu dari API, bukan response dummy 404
      when(() =>
              mockApiHelper.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getAiringToday();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tTvSeriesListPopular = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_popular.json')))
        .tvSeriesList;

    test('should return list of Tv Series when response is success (200)',
        () async {
      // arrange
      // fungsi when tidak mau bekerja
      // hasil dari act selalu dari API, bukan data dummy
      when(() => mockApiHelper.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_popular.json'), 200));
      // act
      final result = await dataSource.getPopular();
      // assert
      expect(result, tTvSeriesListPopular);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      // fungsi when tidak mau bekerja
      // hasil dari act selalu dari API, bukan response dummy 404
      when(() => mockApiHelper.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopular();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tTvSeriesListTopRated = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_top_rated.json')))
        .tvSeriesList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(() => mockApiHelper.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRated();
      // assert
      expect(result, tTvSeriesListTopRated);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(() => mockApiHelper.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRated();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Series detail', () {
    const tId = 1;

    test('should return Tv Series detail when the response code is 200',
        () async {
      // arrange
      final tTvSeriesDetail = TvSeriesDetailModel.fromJson(
          json.decode(readJson('dummy_data/tv_series_detail.json')));
      // final tTvSeriesDetail = readJson('dummy_data/tv_series_detail.json');

      when(() => mockApiHelper.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeriesDetail(id: tId);
      // assert
      expect(result, equals(tTvSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiHelper.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesDetail(id: tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Tv Series', () {
    final tSearchResult = TvSeriesResponse.fromJson(json
            .decode(readJson('dummy_data/tv_series_search_tagesschau.json')))
        .tvSeriesList;
    const tQuery = 'Tagesschau';

    test('should return list of Tv Series when response code is 200', () async {
      // arrange
      when(() => mockApiHelper
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_search_tagesschau.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(() => mockApiHelper
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
