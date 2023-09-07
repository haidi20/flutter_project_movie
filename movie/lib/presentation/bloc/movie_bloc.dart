import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getMovieRecommendations,
  ) : super(Empty()) {
    on<FetchMovieDetail>(fetchMovieDetail);
  }

  Future<void> fetchMovieDetail(event, emit) async {
    emit(Loading());

    final result = await _getMovieDetail.execute(event.id);
    final recommendationResult =
        await _getMovieRecommendations.execute(event.id);

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (movieDetail) {
        emit(Loading());
        recommendationResult.fold(
          (failure) {
            emit(Error(failure.message));
          },
          (moviesRecommendations) {
            emit(DataDetailLoaded(
              movieDetail,
              moviesRecommendations,
            ));
          },
        );
      },
    );
  }
}

class WatchListBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchListBloc(
    this._getWatchlistMovies,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(Empty()) {
    on<FetchWatchListMovies>(fetchWatchlistMovies);
    on<FetchWatchListStatus>(fetchWatchListStatus);
    on<AddWatchlist>(addWatchList);
    on<RemoveFromWatchlist>(removeFromWatchlist);
  }

  Future<void> fetchWatchlistMovies(event, emit) async {
    emit(Loading());

    final result = await _getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(WatchListMessage(failure.message));
      },
      (moviesData) {
        if (moviesData.isEmpty) {
          emit(Empty());
        } else {
          emit(WatchListDataLoaded(moviesData));
        }
      },
    );
  }

  Future<void> fetchWatchListStatus(event, emit) async {
    emit(Loading());

    final result = await _getWatchListStatus.execute(event.id);

    emit(WatchListStatusLoaded(result));
  }

  Future<void> addWatchList(event, emit) async {
    final result = await _saveWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        emit(WatchListMessage(failure.message));
      },
      (successMessage) async {
        emit(WatchListMessage(successMessage));
        add(FetchWatchListStatus(event.movie.id));
      },
    );
  }

  Future<void> removeFromWatchlist(event, emit) async {
    final result = await _removeWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        emit(WatchListMessage(failure.message));
      },
      (successMessage) async {
        emit(WatchListMessage(successMessage));
        add(FetchWatchListStatus(event.movie.id));
      },
    );
  }
}

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
      (nowPlayings) {
        if (nowPlayings.isEmpty) {
          emit(Empty());
        } else {
          emit(DataLoaded(nowPlayings));
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
      (populars) {
        if (populars.isEmpty) {
          emit(Empty());
        } else {
          emit(DataLoaded(populars));
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
      (topRateds) {
        if (topRateds.isEmpty) {
          emit(Empty());
        } else {
          emit(DataLoaded(topRateds));
        }
      },
    );
  }
}
