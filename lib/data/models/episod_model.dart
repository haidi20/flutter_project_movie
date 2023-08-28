import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;
  final List<dynamic>? crew;
  final List<dynamic>? guestStars;

  EpisodeModel({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.crew,
    this.guestStars,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      episodeType: json['episode_type'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      productionCode: json['production_code'],
      runtime: json['runtime'],
      seasonNumber: json['season_number'],
      showId: json['show_id'],
      stillPath: json['still_path'],
      voteAverage: json['vote_average']?.toDouble(),
      voteCount: json['vote_count'],
      crew: json['crew'] != null ? List<dynamic>.from(json['crew']) : null,
      guestStars: json['guest_stars'] != null
          ? List<dynamic>.from(json['guest_stars'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'id': id,
      'name': name,
      'overview': overview,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'crew': crew,
      'guest_stars': guestStars,
    };
  }

  Episode toEntity() {
    return Episode(
      airDate: airDate,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      crew: crew,
      guestStars: guestStars,
    );
  }

  List<Object?> get props => [
        airDate,
        episodeNumber,
        episodeType,
        id,
        name,
        overview,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
        crew,
        guestStars,
      ];
}
