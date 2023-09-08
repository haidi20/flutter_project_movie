import 'package:tv_series/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  const SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage
      ];

  // Convert a Map (JSON) into an instance of SeasonModel
  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      airDate: json['air_date'],
      episodeCount: json['episode_count'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  // Convert an instance of SeasonModel to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'air_date': airDate,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }

  // Convert an instance of SeasonModel to an instance of Season entity
  Season toEntity() {
    return Season(
      airDate: airDate ?? "",
      episodeCount: episodeCount ?? 0,
      id: id ?? 0,
      name: name ?? "",
      overview: overview ?? "",
      posterPath: posterPath ?? "",
      seasonNumber: seasonNumber ?? 0,
      voteAverage: voteAverage ?? 0,
    );
  }
}
