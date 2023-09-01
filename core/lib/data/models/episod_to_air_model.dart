import 'package:core/domain/entities/episod_to_air.dart';
import 'package:equatable/equatable.dart';

class EpisodeToAirModel extends Equatable {
  EpisodeToAirModel({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  final int? id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  factory EpisodeToAirModel.fromJson(Map<String, dynamic> json) {
    return EpisodeToAirModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int?,
      episodeType: json['episode_type'] as String?,
      productionCode: json['production_code'] as String?,
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int?,
      showId: json['show_id'] as int?,
      stillPath: json['still_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
    };
  }

  EpisodeToAir toEntity() {
    return EpisodeToAir(
      id: id,
      name: name,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      airDate: airDate,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath,
    );
  }

  List<Object?> get props => [
        id,
        name,
        overview,
        voteAverage,
        voteCount,
        airDate,
        episodeNumber,
        episodeType,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath
      ];
}
