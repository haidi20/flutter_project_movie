import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/data/models/episod_to_air_model.dart';
import 'package:tv_series/data/models/network_model.dart';
import 'package:tv_series/data/models/production_company_model.dart';
import 'package:tv_series/data/models/production_country_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/domain/entities/episod_to_air.dart';
import 'package:tv_series/domain/entities/network.dart';
import 'package:tv_series/domain/entities/production_company.dart';
import 'package:tv_series/domain/entities/production_country.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
    adult: false,
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    createdBy: const [],
    episodeRunTime: const [15],
    firstAirDate: "1952-12-26",
    genres: [
      GenreModel(id: 10763, name: "News"),
    ],
    homepage: "https://www.tagesschau.de/",
    id: 94722,
    inProduction: true,
    languages: const ["de"],
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
    networks: const [
      NetworkModel(
          id: 308,
          logoPath: "/fc0O0mvjl8PbHgZXXY2VgPYos1Z.png",
          name: "ARD",
          originCountry: "DE")
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
          originCountry: "DE")
    ],
    productionCountries: const [
      ProductionCountryModel(iso31661: "DE", name: "Germany")
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
      SpokenLanguageModel(englishName: "German", iso6391: "de", name: "Deutsch")
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
    createdBy: const [],
    episodeRunTime: const [15],
    firstAirDate: "1952-12-26",
    genres: const [
      Genre(id: 10763, name: "News"),
    ],
    homepage: "https://www.tagesschau.de/",
    id: 94722,
    inProduction: true,
    languages: const ["de"],
    lastAirDate: "2023-08-22",
    lastEpisodeToAir: const EpisodeToAir(
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
    nextEpisodeToAir: const EpisodeToAir(
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
      Network(
          id: 308,
          logoPath: "/fc0O0mvjl8PbHgZXXY2VgPYos1Z.png",
          name: "ARD",
          originCountry: "DE")
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
      ProductionCompany(
          id: 7201,
          logoPath: "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
          name: "NDR",
          originCountry: "DE")
    ],
    productionCountries: [ProductionCountry(iso31661: "DE", name: "Germany")],
    seasons: const [
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
      SpokenLanguage(englishName: "German", iso6391: "de", name: "Deutsch")
    ],
    status: "Returning Series",
    tagline: "",
    type: "News",
    voteAverage: 7.531,
    voteCount: 127,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesDetailModel.toEntity();
    expect(result, tTvSeriesDetail);
  });
}
