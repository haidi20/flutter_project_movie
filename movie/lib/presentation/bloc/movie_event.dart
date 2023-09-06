part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {
  const FetchMovies();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MovieEvent {
  const FetchNowPlayingMovies();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends MovieEvent {
  const FetchPopularMovies();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMovies extends MovieEvent {
  const FetchTopRatedMovies();

  @override
  List<Object> get props => [];
}
