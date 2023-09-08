part of 'tv_series_search_bloc.dart';

abstract class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesOnQueryChanged extends TvSeriesEvent {
  final String query;

  const TvSeriesOnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
