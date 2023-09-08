part of 'tv_series_bloc.dart';

abstract class TvSeriesState extends Equatable {
  const TvSeriesState();

  @override
  List<Object> get props => [];
}

class DataLoaded extends TvSeriesState {
  final List<TvSeries> result;

  const DataLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class DataDetailLoaded extends TvSeriesState {
  final TvSeriesDetail tvSeriesDetail;
  final List<Season> seasons;

  const DataDetailLoaded(
    this.tvSeriesDetail,
    this.seasons,
  );

  @override
  List<Object> get props => [
        tvSeriesDetail,
        seasons,
      ];
}

class SeasonDataLoaded extends TvSeriesState {
  final List<Season> result;

  const SeasonDataLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class SeasinDetailLoaded extends TvSeriesState {
  final SeasonDetail result;

  const SeasinDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchListDataLoaded extends TvSeriesState {
  final List<TvSeries> result;

  const WatchListDataLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchListStatusLoaded extends TvSeriesState {
  final bool status;

  const WatchListStatusLoaded(this.status);

  @override
  List<Object> get props => [status];
}

class WatchListMessage extends TvSeriesState {
  final String message;

  const WatchListMessage(this.message);

  @override
  List<Object> get props => [message];
}

class Empty extends TvSeriesState {}

class Loading extends TvSeriesState {}

class Error extends TvSeriesState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
