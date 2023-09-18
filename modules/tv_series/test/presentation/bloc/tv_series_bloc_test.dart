import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_airing_today.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_top_rated.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';

import '../provider/tv_series_popular_notifier_test.mocks.dart';
import 'tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesAiringToday,
  GetTvSeriesDetail,
  GetTvSeriesTopRated,
])
void main() {
  late TvSeriesAiringTodayBloc tvSeriesAiringTodayBloc;
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;

  late MockGetTvSeriesAiringToday mockGetTvSeriesAiringToday;
  late MockGetTvSeriesPopular mockGetTvSeriesPopular;
  late MockGetTvSeriesTopRated mockGetTvSeriesTopRated;

  setUp(() {
    mockGetTvSeriesAiringToday = MockGetTvSeriesAiringToday();
    mockGetTvSeriesPopular = MockGetTvSeriesPopular();
    mockGetTvSeriesTopRated = MockGetTvSeriesTopRated();

    tvSeriesAiringTodayBloc = TvSeriesAiringTodayBloc(
      mockGetTvSeriesAiringToday,
    );
    tvSeriesPopularBloc = TvSeriesPopularBloc(
      mockGetTvSeriesPopular,
    );
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(
      mockGetTvSeriesTopRated,
    );
  });

  test('initial state should be empty', () {
    expect(tvSeriesAiringTodayBloc.state, Empty());
  });

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

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesAiringTodayBloc, TvSeriesState>(
    'Should emit [Loading, HasData] when fetch get now playing tv series is gotten successfully',
    build: () {
      when(mockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesAiringTodayBloc;
    },
    act: (bloc) => bloc.add(const FetchAiringToday()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      DataLoaded(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesAiringToday.execute());
    },
  );

  blocTest<TvSeriesAiringTodayBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get now playing tv series is unsuccessful',
    build: () {
      when(mockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesAiringTodayBloc;
    },
    act: (bloc) => bloc.add(const FetchAiringToday()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesAiringToday.execute());
    },
  );

  blocTest<TvSeriesPopularBloc, TvSeriesState>(
    'Should emit [Loading, HasData] when fetch get popular tv series is gotten successfully',
    build: () {
      when(mockGetTvSeriesPopular.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesPopularBloc;
    },
    act: (bloc) => bloc.add(const FetchPopular()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      DataLoaded(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesPopular.execute());
    },
  );

  blocTest<TvSeriesPopularBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get popular tv series is unsuccessful',
    build: () {
      when(mockGetTvSeriesPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesPopularBloc;
    },
    act: (bloc) => bloc.add(const FetchPopular()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesPopular.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesState>(
    'Should emit [Loading, HasData] when fetch get top rated tv series is gotten successfully',
    build: () {
      when(mockGetTvSeriesTopRated.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRated()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      DataLoaded(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesTopRated.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetTvSeriesTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRated()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesTopRated.execute());
    },
  );
}
