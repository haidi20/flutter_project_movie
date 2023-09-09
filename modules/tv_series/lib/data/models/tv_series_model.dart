import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  const TvSeriesModel({
    this.backdropPath,
    this.firstAirDate,
    required this.genreIds,
    required this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String posterPath;
  final double? voteAverage;
  final int? voteCount;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      id: json['id'],
      name: json['name'],
      originCountry:
          List<String>.from(json['origin_country']?.map((x) => x) ?? []),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
      'id': id,
      'name': name,
      'origin_country': List<dynamic>.from(originCountry?.map((x) => x) ?? []),
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  // Assuming there's another entity class named TvSeries for toEntity()
  TvSeries toEntity() {
    return TvSeries(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      id: id,
      name: name,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
