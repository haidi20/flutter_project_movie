import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final int? id;
  final String? id_underscore;
  final String? airDate;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;
  final List<Episode> episodes;

  SeasonDetail({
    this.id,
    this.id_underscore,
    this.airDate,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
        id,
        id_underscore,
        airDate,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
        episodes,
      ];
}
