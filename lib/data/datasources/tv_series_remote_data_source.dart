import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_response.dart';

import 'package:ditonton/data/models/tv_series_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async {
    final response =
        await http.get(Uri.parse('$BASE_URL/movie/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).TvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }
}
