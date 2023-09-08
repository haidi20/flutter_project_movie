import 'dart:convert';

import 'package:tv_series/data/models/episod_model.dart';
import 'package:tv_series/data/models/season_detail_model.dart';
import 'package:tv_series/data/models/tv_series_season_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesSeasonDetail = SeasonDetailModel(
    idUnderscore: "5dac967fed28b90014dbbc04",
    id: 134441,
    airDate: "1952-12-26",
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
    episodes: [
      EpisodeModel(
        airDate: "1952-12-26",
        episodeNumber: 1,
        episodeType: "standard",
        id: 1958839,
        name: "Episode 1",
        overview: "",
        productionCode: "",
        runtime: 15,
        seasonNumber: 1,
        showId: 94722,
        stillPath: null,
        voteAverage: 1.0,
        voteCount: 2,
        crew: [],
        guestStars: [],
      ),
    ],
  );

  final tTvSeriesSeasonResponseModel =
      TvSeriesSeasonResponse(seasonDetail: tTvSeriesSeasonDetail);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_seasons.json'));
      // act
      final result = TvSeriesSeasonResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesSeasonResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesSeasonResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "_id": "5dac967fed28b90014dbbc04",
        "air_date": "1952-12-26",
        "episodes": [
          {
            "air_date": "1952-12-26",
            "episode_number": 1,
            "episode_type": "standard",
            "id": 1958839,
            "name": "Episode 1",
            "overview": "",
            "production_code": "",
            "runtime": 15,
            "season_number": 1,
            "show_id": 94722,
            "still_path": null,
            "vote_average": 1.0,
            "vote_count": 2,
            "crew": [],
            "guest_stars": []
          }
        ],
        "name": "Season 1952",
        "overview": "",
        "id": 134441,
        "poster_path": "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
        "season_number": 1,
        "vote_average": 3.5
      };
      expect(result, expectedJsonMap);
    });
  });
}
