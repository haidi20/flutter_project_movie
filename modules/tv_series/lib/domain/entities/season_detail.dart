import 'package:tv_series/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final int? id;
  final String? idUnderscore;
  final String? airDate;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;
  final List<Episode> episodes;

  const SeasonDetail({
    this.id,
    this.idUnderscore,
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
        idUnderscore,
        airDate,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
        episodes,
      ];
}
