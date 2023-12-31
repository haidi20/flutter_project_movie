import 'package:tv_series/data/models/episod_to_air_model.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:tv_series/data/models/network_model.dart';
import 'package:tv_series/data/models/production_company_model.dart';
import 'package:tv_series/data/models/production_country_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  const TvSeriesDetailModel({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    required this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final EpisodeToAirModel? lastEpisodeToAir;
  final String? name;
  final EpisodeToAirModel? nextEpisodeToAir;
  final List<NetworkModel>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String posterPath;
  final List<ProductionCompanyModel>? productionCompanies;
  final List<ProductionCountryModel>? productionCountries;
  final List<SeasonModel>? seasons;
  final List<SpokenLanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TvSeriesDetailModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        createdBy = List<dynamic>.from(json['created_by'] ?? []),
        episodeRunTime = List<int>.from(json['episode_run_time'] ?? []),
        firstAirDate = json['first_air_date'],
        genres = List<GenreModel>.from(
            json["genres"]?.map((x) => GenreModel.fromJson(x)) ?? []),
        homepage = json['homepage'],
        id = json['id'],
        inProduction = json['in_production'],
        languages = List<String>.from(json['languages'] ?? []),
        lastAirDate = json['last_air_date'],
        lastEpisodeToAir = json['last_episode_to_air'] != null
            ? EpisodeToAirModel.fromJson(json['last_episode_to_air'])
            : null,
        name = json['name'],
        nextEpisodeToAir = json['next_episode_to_air'] != null
            ? EpisodeToAirModel.fromJson(json['next_episode_to_air'])
            : null,
        networks = List<NetworkModel>.from(
            json["networks"]?.map((x) => NetworkModel.fromJson(x)) ?? []),
        numberOfEpisodes = json['number_of_episodes'],
        numberOfSeasons = json['number_of_seasons'],
        originCountry = List<String>.from(json['origin_country'] ?? []),
        originalLanguage = json['original_language'],
        originalName = json['original_name'],
        overview = json['overview'],
        popularity = json['popularity']?.toDouble(),
        posterPath = json['poster_path'],
        productionCompanies = List<ProductionCompanyModel>.from(
            json["production_companies"]
                    ?.map((x) => ProductionCompanyModel.fromJson(x)) ??
                []),
        productionCountries = List<ProductionCountryModel>.from(
            json["production_countries"]
                    ?.map((x) => ProductionCountryModel.fromJson(x)) ??
                []),
        seasons = List<SeasonModel>.from(
            json["seasons"]?.map((x) => SeasonModel.fromJson(x)) ?? []),
        spokenLanguages = List<SpokenLanguageModel>.from(
            json["spoken_languages"]
                    ?.map((x) => SpokenLanguageModel.fromJson(x)) ??
                []),
        status = json['status'],
        tagline = json['tagline'],
        type = json['type'],
        voteAverage = json['vote_average']?.toDouble(),
        voteCount = json['vote_count'];

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'created_by': createdBy,
        'episode_run_time': episodeRunTime,
        'first_air_date': firstAirDate,
        'genres': genres?.map((i) => i.toJson()).toList(),
        'homepage': homepage,
        'id': id,
        'in_production': inProduction,
        'languages': languages,
        'last_air_date': lastAirDate,
        'last_episode_to_air':
            lastEpisodeToAir != null ? lastEpisodeToAir!.toJson() : null,
        'name': name,
        'next_episode_to_air': nextEpisodeToAir?.toJson(),
        'networks': networks?.map((i) => i.toJson()).toList(),
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies':
            productionCompanies?.map((i) => i.toJson()).toList(),
        'production_countries':
            productionCountries?.map((i) => i.toJson()).toList(),
        'seasons': seasons?.map((i) => i.toJson()).toList(),
        'spoken_languages': spokenLanguages?.map((i) => i.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'type': type,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  // For the toEntity method, I'm assuming an Entity class exists and you'd want to convert to it
  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: adult ?? false,
      backdropPath: backdropPath,
      createdBy: createdBy,
      episodeRunTime: episodeRunTime ?? [],
      firstAirDate: firstAirDate ?? "",
      genres: genres?.map((genre) => genre.toEntity()).toList() ?? [],
      homepage: homepage,
      id: id,
      inProduction: inProduction ?? false,
      languages: languages ?? [],
      lastAirDate: lastAirDate ?? "",
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name ?? "",
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
      networks: networks?.map((network) => network.toEntity()).toList() ?? [],
      numberOfEpisodes: numberOfEpisodes ?? 0,
      numberOfSeasons: numberOfSeasons ?? 0,
      originCountry: originCountry ?? [],
      originalLanguage: originalLanguage ?? "",
      originalName: originalName ?? "",
      overview: overview ?? "",
      popularity: popularity ?? 0.0,
      posterPath: posterPath,
      productionCompanies:
          productionCompanies?.map((company) => company.toEntity()).toList() ??
              [],
      productionCountries:
          productionCountries?.map((country) => country.toEntity()).toList() ??
              [],
      seasons: seasons?.map((season) => season.toEntity()).toList() ?? [],
      spokenLanguages:
          spokenLanguages?.map((language) => language.toEntity()).toList() ??
              [],
      status: status ?? "",
      tagline: tagline ?? "",
      type: type ?? "",
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount
      ];
}
