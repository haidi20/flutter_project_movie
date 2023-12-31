import 'package:tv_series/data/models/episod_model.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailModel extends Equatable {
  final int? id;
  final String? idUnderscore;
  final String? airDate;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;
  final List<EpisodeModel> episodes;

  const SeasonDetailModel({
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

  // Deserialize JSON to SeasonDetailModel
  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) {
    List<EpisodeModel> episodes;
    // if (json['episodes'] != null) {
    episodes = List<EpisodeModel>.from(
        json['episodes'].map((episode) => EpisodeModel.fromJson(episode)));
    // }

    return SeasonDetailModel(
      id: json['id'],
      idUnderscore: json['_id'],
      airDate: json['air_date'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average']?.toDouble(),
      episodes: episodes,
    );
  }

  // Serialize SeasonDetailModel to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['_id'] = idUnderscore;
    data['air_date'] = airDate;
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    data['vote_average'] = voteAverage;
    data['episodes'] = episodes.map((episode) => episode.toJson()).toList();
    return data;
  }

  // Convert SeasonDetailModel to Entity
  SeasonDetail toEntity() {
    return SeasonDetail(
      id: id,
      idUnderscore: idUnderscore,
      airDate: airDate,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  List<Object?> get props => [
        id,
        airDate,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
        episodes,
      ];
}
