import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TvSeries extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String posterPath;
  final double? voteAverage;
  final int? voteCount;

  const TvSeries({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    required this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    required this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  const TvSeries.watchlist({
    required this.id,
    this.overview,
    required this.posterPath,
    this.name,
  })  : backdropPath = null,
        firstAirDate = null,
        genreIds = null,
        originCountry = null,
        originalLanguage = null,
        originalName = null,
        popularity = null,
        voteAverage = null,
        voteCount = null;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
