import 'package:ditonton/data/models/episod_to_air_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/networks.dart';
import 'package:ditonton/domain/entities/product_company.dart';
import 'package:ditonton/domain/entities/production_country.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalLanguage: "en",
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final tMovieModel = MovieModel(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalLanguage: "en",
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final tMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalLanguage: "en",
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final tMovieResponse = MovieDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  budget: 100,
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  imdbId: 'imdb1',
  originalLanguage: 'en',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  revenue: 12000,
  runtime: 120,
  status: 'Status',
  tagline: 'Tagline',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

// start tv series
final testTvSeriesMap = {
  'id': 94722,
  'overview':
      "German daily news program, the oldest still existing program on German television.",
  'posterPath': "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  'name': 'Tagesschau',
};

final testTvSeriesTable = TvSeriesTable(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

final testTvSeriesCacheMap = {
  'id': 94722,
  'overview':
      "German daily news program, the oldest still existing program on German television.",
  'posterPath': "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  'name': 'Tagesschau',
};

final testTvSeriesCache = TvSeriesTable(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

final testeTvSeriesWatchList = TvSeries.watchlist(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

final testTvSeriesDetail = TvSeriesDetail(
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
// end tv series
