import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

const testMovie = Movie(
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

const testMovieDetail = MovieDetail(
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

final testMovieDetailList = [testMovieDetail];

const testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
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

const testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

const testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

const tMovieModel = MovieModel(
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

const tMovie = Movie(
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

const testTvSeriesTable = TvSeriesTable(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

final List<TvSeriesTable> testTvSeriesTableList = [testTvSeriesTable];

const testTvSeries = TvSeries(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
  firstAirDate: "1952-12-26",
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  genreIds: [10763],
  originCountry: ["DE"],
  originalLanguage: "de",
  originalName: "Tagesschau",
  popularity: 5104.121,
  voteAverage: 7.5,
  voteCount: 127,
);

final List<TvSeries> testTvSeriesList = [testTvSeries];

final testTvSeriesCacheMap = {
  'id': 94722,
  'overview':
      "German daily news program, the oldest still existing program on German television.",
  'posterPath': "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  'name': 'Tagesschau',
};

const testTvSeriesCache = TvSeriesTable(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

const testeTvSeriesWatchList = TvSeries.watchlist(
  id: 94722,
  name: "Tagesschau",
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  createdBy: const [],
  episodeRunTime: const [15],
  firstAirDate: "1952-12-26",
  genres: const [
    Genre(
      id: 10763,
      name: "News",
    ),
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
      originCountry: "DE",
    ),
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
      originCountry: "DE",
    ),
  ],
  productionCountries: [
    ProductionCountry(
      iso31661: "DE",
      name: "Germany",
    ),
  ],
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

const testSeason = Season(
  airDate: "1952-12-26",
  episodeCount:
      1, // Derived from the length of the episodes array in the provided JSON
  id: 134441,
  name: "Season 1952",
  overview: "",
  seasonNumber: 1,
  voteAverage: 3.5,
);

final testSeasonList = [testSeason];


// end tv series