import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:core/data/models/tv_series_season_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringToday();
  Future<List<TvSeriesModel>> getPopular();
  Future<List<TvSeriesModel>> getTopRated();
  Future<SeasonDetailModel> getTvSeriesSeason(
      {required int id, required int seasonNumber});
  Future<List<TvSeriesModel>> getTvSeriesRecommendation({required int id});
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id});
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringToday() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).TvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopular() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).TvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).TvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getTvSeriesSeason(
      {required int id, required int seasonNumber}) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      SeasonDetailModel getData =
          TvSeriesSeasonResponse.fromJson(json.decode(response.body))
              .seasonDetail;

      return getData;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(
      {required int id}) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).TvSeriesList;

      return getData;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id}) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).TvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
