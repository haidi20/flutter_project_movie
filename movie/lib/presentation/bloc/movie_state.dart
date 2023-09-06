part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class DataLoaded extends MovieState {
  final List<Movie> result;

  const DataLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class Empty extends MovieState {}

class Loading extends MovieState {}

class Error extends MovieState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHasNowPlayingData extends MovieState {
  final List<Movie> nowPlaying;

  const MovieHasNowPlayingData(this.nowPlaying);

  @override
  List<Object> get props => [nowPlaying];
}

class NowPlayingError extends MovieState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingLoading extends MovieState {}

class NowPlayingEmpty extends MovieState {}

class MovieHasPopularData extends MovieState {
  final List<Movie> popular;

  const MovieHasPopularData(this.popular);

  @override
  List<Object> get props => [popular];
}

class PopularError extends MovieState {
  final String message;

  const PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularLoading extends MovieState {}

class PopularEmpty extends MovieState {}

class MovieHasTopRatedData extends MovieState {
  final List<Movie> topRated;

  const MovieHasTopRatedData(this.topRated);

  @override
  List<Object> get props => [topRated];
}

class TopRatedError extends MovieState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedLoading extends MovieState {}

class TopRatedEmpty extends MovieState {}
