import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

// class MovieBloc extends Bloc<MovieEvent, MovieState> {

// }

class MovieNowPlayingBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(
    this._getNowPlayingMovies,
  ) : super(Empty()) {
    on<FetchNowPlayingMovies>(fetchNowPlayingMovies);
  }

  Future<void> fetchNowPlayingMovies(event, emit) async {
    emit(Loading());

    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (nowPlaying) {
        if (nowPlaying.isEmpty) {
          emit(Empty());
        } else {
          emit(MovieHasNowPlayingData(nowPlaying));
        }
      },
    );
  }
}

class MoviePopularBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(
    this._getPopularMovies,
  ) : super(Empty()) {
    on<FetchPopularMovies>(fetchPopularMovies);
  }

  Future<void> fetchPopularMovies(event, emit) async {
    emit(Loading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (popular) {
        if (popular.isEmpty) {
          emit(Empty());
        } else {
          emit(DataLoaded(popular));
        }
      },
    );
  }
}

class MovieTopRatedBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(
    this._getTopRatedMovies,
  ) : super(Empty()) {
    on<FetchTopRatedMovies>(fetchTopRatedMovies);
  }

  Future<void> fetchTopRatedMovies(event, emit) async {
    emit(Loading());

    final result = await _getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (topRated) {
        if (topRated.isEmpty) {
          emit(Empty());
        } else {
          emit(DataLoaded(topRated));
        }
      },
    );
  }
}
