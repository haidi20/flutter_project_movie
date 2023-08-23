import 'dart:convert';

import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_response.dart';

import 'package:ditonton/data/models/tv_series_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringToday();
  Future<List<TvSeriesModel>> getPopular();
  Future<List<TvSeriesModel>> getTopRated();
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id});
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
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id}) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
