part of 'tv_series_search_bloc.dart';

abstract class TvSeriesState extends Equatable {
  const TvSeriesState();

  @override
  List<Object> get props => [];
}

class TvSeriesSearchEmpty extends TvSeriesState {}

class TvSeriesSearchLoading extends TvSeriesState {}

class TvSeriesSearchError extends TvSeriesState {
  final String message;

  const TvSeriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesSearchHasData extends TvSeriesState {
  final List<TvSeries> result;

  const TvSeriesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
