import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesSeasonModel = SeasonModel(
    airDate: "1952-12-26",
    episodeCount: 6,
    id: 134441,
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
  );

  const tTvSeriesSeason = Season(
    airDate: "1952-12-26",
    episodeCount: 6,
    id: 134441,
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesSeasonModel.toEntity();
    expect(result, tTvSeriesSeason);
  });
}
