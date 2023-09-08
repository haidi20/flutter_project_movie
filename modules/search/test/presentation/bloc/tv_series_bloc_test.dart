import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/tv_series_search_bloc.dart';

import 'tv_series_bloc_test.mocks.dart';

@GenerateMocks([TvSeriesSearch])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockTvSeriesSearch mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockTvSeriesSearch();
    tvSeriesSearchBloc = TvSeriesSearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(tvSeriesSearchBloc.state, TvSeriesSearchEmpty());
  });

  const tTvSeries = TvSeries(
    id: 94722,
    name: "Tagesschau",
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    backdropPath: 'path/to/backdrop.jpg',
    firstAirDate: '2023-08-23',
    genreIds: [1, 2, 3],
    originCountry: ['US', 'UK'],
    originalLanguage: 'English',
    originalName: 'Original Name',
    popularity: 7.8,
    voteAverage: 7.5,
    voteCount: 1000,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];
  const tQuery = 'spiderman';

  blocTest<TvSeriesSearchBloc, TvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesOnQueryChanged(tQuery)),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
