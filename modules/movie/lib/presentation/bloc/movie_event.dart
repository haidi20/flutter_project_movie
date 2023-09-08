part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => <Object?>[];
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

class FetchMovieDetail extends MovieEvent {
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchMovieRecommendation extends MovieEvent {
  final int id;

  const FetchMovieRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchWatchListStatus extends MovieEvent {
  final int id;

  const FetchWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchWatchListMovies extends MovieEvent {
  const FetchWatchListMovies();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends MovieEvent {
  final MovieDetail movie;

  const AddWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveFromWatchlist extends MovieEvent {
  final MovieDetail movie;

  const RemoveFromWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}
