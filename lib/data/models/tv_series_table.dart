import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvSeriesTable({
    required this.id,
    this.name,
    this.posterPath,
    this.overview,
  });

  // Convert TvSeries entity to TvSeriesTable
  factory TvSeriesTable.fromEntity(TvSeries entity) {
    return TvSeriesTable(
      id: entity.id,
      name: entity.name,
      posterPath: entity.posterPath,
      overview: entity.overview,
    );
  }

  // Convert Map to TvSeriesTable
  factory TvSeriesTable.fromMap(Map<String, dynamic> map) {
    return TvSeriesTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
    );
  }

  // Convert TvSeriesTable to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  // Convert TvSeriesTable to TvSeries
  TvSeries toEntity() => TvSeries.watchlistTvSeries(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  // Assuming TvSeriesDTO is another data representation, you might need to define this DTO first.
  factory TvSeriesTable.fromDTO(TvSeriesModel tvSeriesModel) {
    return TvSeriesTable(
      id: tvSeriesModel.id,
      name: tvSeriesModel.name,
      posterPath: tvSeriesModel.posterPath,
      overview: tvSeriesModel.overview,
    );
  }

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}

// You will need to define TvSeries and TvSeriesDTO if they are not already defined.
