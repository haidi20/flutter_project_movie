import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_airing_today.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_popular.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';
import 'package:tv_series/domain/usecases/get_tv_series_top_rated.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist.dart';

part 'tv_series_event.dart';
part 'tv_series_state.dart';

class TvSeriesDetailBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(
    this._getTvSeriesDetail,
  ) : super(Empty()) {
    on<FetchTvSeriesDetail>(fetchTvSeriesDetail);
  }

  Future<void> fetchTvSeriesDetail(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesDetail.execute(event.id);

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (movieDetail) {
        emit(DataDetailLoaded(movieDetail, movieDetail.seasons ?? []));
      },
    );
  }
}

class TvSeriesRecommendationBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesRecommendation _getTvSeriesRecommendation;

  TvSeriesRecommendationBloc(
    this._getTvSeriesRecommendation,
  ) : super(Empty()) {
    on<FetchRecommendation>(fetchRecommendation);
  }

  Future<void> fetchRecommendation(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesRecommendation.execute(event.id);

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (recommendations) {
        emit(DataLoaded(recommendations));
      },
    );
  }
}

class TvSeriesSeasonBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesSeason _getTvSeriesSeason;

  TvSeriesSeasonBloc(
    this._getTvSeriesSeason,
  ) : super(Empty()) {
    on<FetchSeason>(fetchSeason);
  }

  Future<void> fetchSeason(event, emit) async {
    emit(Loading());

    final result =
        await _getTvSeriesSeason.execute(event.id, event.seassonNumber);

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (tvSeriesSeasonDetail) {
        emit(SeasonDetailLoaded(tvSeriesSeasonDetail));
      },
    );
  }
}

class TvSeriesWatchListBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesWatchList _getTvSeriesWatchList;
  final GetTvSeriesWatchListStatus _getTvSeriesWatchListStatus;
  final TvSeriesSaveWatchList _tvSeriesSaveWatchList;
  final TvSeriesRemoveWatchlist _tvSeriesRemoveWatchlist;

  TvSeriesWatchListBloc(
    this._getTvSeriesWatchList,
    this._getTvSeriesWatchListStatus,
    this._tvSeriesSaveWatchList,
    this._tvSeriesRemoveWatchlist,
  ) : super(Empty()) {
    on<FetchWatchListData>(fetchWatchListData);
    on<FetchWatchListStatus>(fetchWatchlistStatus);
    on<AddWatchlist>(addWatchList);
    on<RemoveFromWatchlist>(removeFromWatchlist);
  }

  Future<void> fetchWatchlistStatus(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesWatchListStatus.execute(event.id);

    emit(WatchListStatusLoaded(result));
  }

  Future<void> fetchWatchListData(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesWatchList.execute();

    result.fold(
      (failure) {
        emit(WatchListMessage(failure.message));
      },
      (tvSeriesData) {
        if (tvSeriesData.isEmpty) {
          emit(Empty());
        } else {
          emit(WatchListDataLoaded(tvSeriesData));
        }
      },
    );
  }

  Future<void> addWatchList(event, emit) async {
    final result = await _tvSeriesSaveWatchList.execute(event.tvSeriesDetail);

    await result.fold(
      (failure) async {
        emit(WatchListMessage(failure.message));
      },
      (successMessage) async {
        // print("add watchlist");
        emit(WatchListMessage(successMessage));
        add(FetchWatchListStatus(event.tvSeriesDetail.id));
      },
    );
  }

  Future<void> removeFromWatchlist(event, emit) async {
    final result = await _tvSeriesRemoveWatchlist.execute(event.tvSeriesDetail);

    await result.fold(
      (failure) async {
        emit(WatchListMessage(failure.message));
      },
      (successMessage) async {
        emit(WatchListMessage(successMessage));
        add(FetchWatchListStatus(event.tvSeriesDetail.id));
      },
    );
  }
}

class TvSeriesAiringTodayBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesAiringToday _getTvSeriesAiringToday;

  TvSeriesAiringTodayBloc(
    this._getTvSeriesAiringToday,
  ) : super(Empty()) {
    on<FetchAiringToday>(fetchNowPlaying);
  }

  Future<void> fetchNowPlaying(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesAiringToday.execute();

    result.fold(
      (failure) {
        emit(Error(failure.message));
      },
      (airingTodays) {
        if (airingTodays.isEmpty) {
          emit(Empty());
        } else {
          emit(DataLoaded(airingTodays));
        }
      },
    );
  }
}

class TvSeriesPopularBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesPopular _getTvSeriesPopular;

  TvSeriesPopularBloc(
    this._getTvSeriesPopular,
  ) : super(Empty()) {
    on<FetchPopular>(fetchPopular);
  }

  Future<void> fetchPopular(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesPopular.execute();

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

class TvSeriesTopRatedBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesTopRated _getTvSeriesTopRated;

  TvSeriesTopRatedBloc(
    this._getTvSeriesTopRated,
  ) : super(Empty()) {
    on<FetchTopRated>(fetchTopRated);
  }

  Future<void> fetchTopRated(event, emit) async {
    emit(Loading());

    final result = await _getTvSeriesTopRated.execute();

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
