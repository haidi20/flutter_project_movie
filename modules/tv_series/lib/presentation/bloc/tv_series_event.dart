part of 'tv_series_bloc.dart';

abstract class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class FetchTvSeriesDetail extends TvSeriesEvent {
  final int id;

  const FetchTvSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchRecommendation extends TvSeriesEvent {
  final int id;

  const FetchRecommendation(
    this.id,
  );

  @override
  List<Object?> get props => [
        id,
      ];
}

class FetchSeason extends TvSeriesEvent {
  final int id;
  final int seassonNumber;

  const FetchSeason(
    this.id,
    this.seassonNumber,
  );

  @override
  List<Object?> get props => [
        id,
        seassonNumber,
      ];
}

class FetchAiringToday extends TvSeriesEvent {
  const FetchAiringToday();

  @override
  List<Object> get props => [];
}

class FetchPopular extends TvSeriesEvent {
  const FetchPopular();

  @override
  List<Object> get props => [];
}

class FetchTopRated extends TvSeriesEvent {
  const FetchTopRated();

  @override
  List<Object> get props => [];
}

class FetchWatchListData extends TvSeriesEvent {
  const FetchWatchListData();

  @override
  List<Object> get props => [];
}

class FetchWatchListStatus extends TvSeriesEvent {
  final int id;

  const FetchWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlist extends TvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddWatchlist(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveFromWatchlist extends TvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveFromWatchlist(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}
