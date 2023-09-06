import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MoviePopularBloc moviePopularBloc;
  late MovieTopRatedBloc movieTopRatedBloc;

  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();

    movieNowPlayingBloc = MovieNowPlayingBloc(
      mockGetNowPlayingMovies,
    );
    moviePopularBloc = MoviePopularBloc(
      mockGetPopularMovies,
    );
    movieTopRatedBloc = MovieTopRatedBloc(
      mockGetTopRatedMovies,
    );
  });

  test('initial state should be empty', () {
    expect(movieNowPlayingBloc.state, Empty());
  });

  const tMovieModel = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalLanguage: "en",
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovieModel];

  blocTest<MovieNowPlayingBloc, MovieState>(
    'Should emit [Loading, HasData] when fetch get now playing movies is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      MovieHasNowPlayingData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieNowPlayingBloc, MovieState>(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MoviePopularBloc, MovieState>(
    'Should emit [Loading, HasData] when fetch get popular movies is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularMovies()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      DataLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviePopularBloc, MovieState>(
    'Should emit [Loading, Error] when get popular movies is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MovieTopRatedBloc, MovieState>(
    'Should emit [Loading, HasData] when fetch get top rated movies is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedMovies()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      DataLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieTopRatedBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated movies is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
