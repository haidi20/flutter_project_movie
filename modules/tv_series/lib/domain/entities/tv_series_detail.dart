import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/episod_to_air.dart';
import 'package:tv_series/domain/entities/network.dart';
import 'package:tv_series/domain/entities/production_company.dart';
import 'package:tv_series/domain/entities/production_country.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/spoken_language.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TvSeriesDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final EpisodeToAir? lastEpisodeToAir;
  final String? name;
  final EpisodeToAir? nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final List<Season>? seasons;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  const TvSeriesDetail({
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
