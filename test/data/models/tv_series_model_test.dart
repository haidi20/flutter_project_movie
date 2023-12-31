import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: 'path/to/backdrop.jpg',
    firstAirDate: '2023-08-23',
    genreIds: [1, 2, 3],
    id: 12345,
    name: 'Dummy TV Series',
    originCountry: ['US', 'UK'],
    originalLanguage: 'English',
    originalName: 'Original Name',
    overview: 'This is a dummy TV series overview.',
    popularity: 7.8,
    posterPath: 'path/to/poster.jpg',
    voteAverage: 7.5,
    voteCount: 1000,
  );

  const tTvSeries = TvSeries(
    backdropPath: 'path/to/backdrop.jpg',
    firstAirDate: '2023-08-23',
    genreIds: [1, 2, 3],
    id: 12345,
    name: 'Dummy TV Series',
    originCountry: ['US', 'UK'],
    originalLanguage: 'English',
    originalName: 'Original Name',
    overview: 'This is a dummy TV series overview.',
    popularity: 7.8,
    posterPath: 'path/to/poster.jpg',
    voteAverage: 7.5,
    voteCount: 1000,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
