import 'dart:convert';

import 'package:tv_series/data/models/tv_series_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:tv_series/data/models/episod_to_air_model.dart';
import 'package:tv_series/data/models/network_model.dart';
import 'package:tv_series/data/models/production_company_model.dart';
import 'package:tv_series/data/models/production_country_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
    adult: false,
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    createdBy: const [], // Assuming this is an empty list in the model
    episodeRunTime: const [15],
    firstAirDate: "1952-12-26",
    genres: [
      GenreModel(id: 10763, name: "News"), // Assuming a Genre model structure
    ],
    homepage: "https://www.tagesschau.de/",
    id: 94722,
    inProduction: true,
    languages: const ["de"],
    lastAirDate: "2023-08-22",
    // Assuming an Episode model structure for lastEpisodeToAir and nextEpisodeToAir
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
    networks: const [
      NetworkModel(
          id: 308,
          logoPath: "/fc0O0mvjl8PbHgZXXY2VgPYos1Z.png",
          name: "ARD",
          originCountry: "DE") // Assuming the Network model structure
    ],
    numberOfEpisodes: 20839,
    numberOfSeasons: 72,
    originCountry: const ["DE"],
    originalLanguage: "de",
    originalName: "Tagesschau",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    popularity: 5104.121,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    productionCompanies: const [
      ProductionCompanyModel(
          id: 7201,
          logoPath: "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
          name: "NDR",
          originCountry: "DE") // Assuming a ProductionCompany model structure
    ],
    productionCountries: const [
      ProductionCountryModel(
          iso31661: "DE",
          name: "Germany") // Assuming a ProductionCountry model structure
    ],
    seasons: const [
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
    spokenLanguages: const [
      SpokenLanguageModel(
          englishName: "German",
          iso6391: "de",
          name: "Deutsch") // Assuming a SpokenLanguage model structure
    ],
    status: "Returning Series",
    tagline: "",
    type: "News",
    voteAverage: 7.531,
    voteCount: 127,
  );

  final tTvSeriesDetailResponseModel = TvSeriesDetailResponse(
    tvSeriesDetail: tTvSeriesDetailModel,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_detail.json'));
      // act
      final result = TvSeriesDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesDetailResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesDetailResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
        "created_by": [],
        "episode_run_time": [15],
        "first_air_date": "1952-12-26",
        "genres": [
          {"id": 10763, "name": "News"}
        ],
        "homepage": "https://www.tagesschau.de/",
        "id": 94722,
        "in_production": true,
        "languages": ["de"],
        "last_air_date": "2023-08-22",
        "last_episode_to_air": {
          "id": 4533092,
          "name": "Episode 234",
          "overview": "",
          "vote_average": 0.0,
          "vote_count": 0,
          "air_date": "2023-08-22",
          "episode_number": 234,
          "episode_type": "standard",
          "production_code": "",
          "runtime": 15,
          "season_number": 72,
          "show_id": 94722,
          "still_path": null
        },
        "name": "Tagesschau",
        "next_episode_to_air": {
          "id": 4533093,
          "name": "Episode 235",
          "overview": "",
          "vote_average": 0.0,
          "vote_count": 0,
          "air_date": "2023-08-23",
          "episode_number": 235,
          "episode_type": "standard",
          "production_code": "",
          "runtime": 15,
          "season_number": 72,
          "show_id": 94722,
          "still_path": null
        },
        "networks": [
          {
            "id": 308,
            "logo_path": "/fc0O0mvjl8PbHgZXXY2VgPYos1Z.png",
            "name": "ARD",
            "origin_country": "DE"
          }
        ],
        "number_of_episodes": 20839,
        "number_of_seasons": 72,
        "origin_country": ["DE"],
        "original_language": "de",
        "original_name": "Tagesschau",
        "overview":
            "German daily news program, the oldest still existing program on German television.",
        "popularity": 5104.121,
        "poster_path": "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
        "production_companies": [
          {
            "id": 7201,
            "logo_path": "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
            "name": "NDR",
            "origin_country": "DE"
          }
        ],
        "production_countries": [
          {"iso_3166_1": "DE", "name": "Germany"}
        ],
        "seasons": [
          {
            "air_date": "1952-12-26",
            "episode_count": 6,
            "id": 134441,
            "name": "Season 1952",
            "overview": "",
            "poster_path": "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
            "season_number": 1,
            "vote_average": 3.5
          }
        ],
        "spoken_languages": [
          {"english_name": "German", "iso_639_1": "de", "name": "Deutsch"}
        ],
        "status": "Returning Series",
        "tagline": "",
        "type": "News",
        "vote_average": 7.531,
        "vote_count": 127
      };
      expect(result, expectedJsonMap);
    });
  });
}
