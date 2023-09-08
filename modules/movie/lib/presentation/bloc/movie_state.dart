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

class DataDetailLoaded extends MovieState {
  final MovieDetail movieDetail;

  const DataDetailLoaded(
    this.movieDetail,
  );

  @override
  List<Object> get props => [
        movieDetail,
      ];
}

class WatchListDataLoaded extends MovieState {
  final List<Movie> result;

  const WatchListDataLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchListStatusLoaded extends MovieState {
  final bool status;

  const WatchListStatusLoaded(this.status);

  @override
  List<Object> get props => [status];
}

class WatchListMessage extends MovieState {
  final String message;

  const WatchListMessage(this.message);

  @override
  List<Object> get props => [message];
}

class Empty extends MovieState {}

class Loading extends MovieState {}

class Error extends MovieState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
