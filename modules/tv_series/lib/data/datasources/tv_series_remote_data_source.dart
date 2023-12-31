import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/datasources/api/api_helper.dart';
import 'package:tv_series/data/models/season_detail_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:tv_series/data/models/tv_series_season_detail_response.dart';

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
  static const apiKey = 'api_key=bfc228e757fb368b3ddd4bb9609def19';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final ApiHelper apiHelper;

  TvSeriesRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<List<TvSeriesModel>> getAiringToday() async {
    final response =
        await apiHelper.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopular() async {
    final response =
        await apiHelper.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRated() async {
    final response =
        await apiHelper.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getTvSeriesSeason(
      {required int id, required int seasonNumber}) async {
    final response = await apiHelper
        .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey'));

    if (response.statusCode == 200) {
      SeasonDetailModel getData =
          TvSeriesSeasonDetailResponse.fromJson(json.decode(response.body))
              .seasonDetail;

      return getData;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(
      {required int id}) async {
    final response = await apiHelper
        .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      List<TvSeriesModel> getData =
          TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;

      return getData;

      // return result;
    } else {
      throw ServerException();
    }
  }

  // @override
  // Future<List<TvSeriesModel>> getTvSeriesRecommendation(
  //     {required int id}) async {
  //   final response =
  //       await apiHelper.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

  //   if (response.statusCode == 200) {
  //     List<TvSeriesModel> getData =
  //         TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;

  //     return getData;
  //   } else {
  //     throw ServerException();
  //   }
  // }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id}) async {
    final response = await apiHelper.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await apiHelper
        .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
