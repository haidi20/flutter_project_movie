import 'package:ditonton/data/models/episod_to_air_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/network_model.dart';
import 'package:ditonton/data/models/product_company_model.dart';
import 'package:ditonton/data/models/product_country_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/spoken_language_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/domain/entities/episod_to_air.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/networks.dart';
import 'package:ditonton/domain/entities/product_company.dart';
import 'package:ditonton/domain/entities/production_country.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
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

  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    createdBy: [],
    episodeRunTime: [15],
    firstAirDate: "1952-12-26",
    genres: [
      Genre(
        id: 10763,
        name: "News",
      ),
    ],
    homepage: "https://www.tagesschau.de/",
    id: 94722,
    inProduction: true,
    languages: ["de"],
    lastAirDate: "2023-08-22",
    lastEpisodeToAir: EpisodeToAir(
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
    nextEpisodeToAir: EpisodeToAir(
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
      Networks(
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
      ProductCompany(
        id: 7201,
        logoPath: "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
        name: "NDR",
        originCountry: "DE",
      ),
    ],
    productionCountries: [
      ProductionCountry(
        iso31661: "DE",
        name: "Germany",
      ),
    ],
    seasons: [
      Season(
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
      SpokenLanguage(
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

  test('should be a subclass of Tv Series detail entity', () async {
    final result = tTvSeriesDetailModel.toEntity();
    expect(result, tTvSeriesDetail);
  });
}
