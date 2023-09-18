import 'package:core/core.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter/foundation.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation getTvSeriesRecommendation;
  final GetTvSeriesSeason getTvSeriesSeason;
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;
  final TvSeriesSaveWatchList tvSeriesSaveWatchList;
  final TvSeriesRemoveWatchlist tvSeriesRemoveWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendation,
    required this.getTvSeriesSeason,
    required this.getTvSeriesWatchListStatus,
    required this.tvSeriesSaveWatchList,
    required this.tvSeriesRemoveWatchlist,
  });

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  RequestState _tvSeriesDetailState = RequestState.isEmpty;
  RequestState get tvSeriesDetailState => _tvSeriesDetailState;
  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesRecommendationsState = RequestState.isEmpty;
  RequestState get getTvSeriesRecommendationState =>
      _tvSeriesRecommendationsState;
  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  final RequestState _tvSeriesSeasonsState = RequestState.isEmpty;
  RequestState get getTvSeriesSeasonsState => _tvSeriesSeasonsState;
  List<Season> _tvSeriesSeasons = [];
  List<Season> get tvSeriesSeasons => _tvSeriesSeasons;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail({required int id}) async {
    _tvSeriesDetailState = RequestState.isLoading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendation.execute(id);
    // final recommendationResult = await getTvSeriesSeason.execute(id, );

    detailResult.fold(
      (failure) {
        _tvSeriesDetailState = RequestState.isError;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesDetail = tvSeries;
        _tvSeriesDetailState = RequestState.isLoaded;
        notifyListeners();

        // season list season
        _tvSeriesSeasons = tvSeries.seasons ?? [];

        // end list season

        recommendationResult.fold(
          (failure) {
            _tvSeriesRecommendationsState = RequestState.isError;
            _message = failure.message;
            notifyListeners();
          },
          (tvSeries) {
            _tvSeriesRecommendations = tvSeries;
            _tvSeriesRecommendationsState = RequestState.isLoaded;
            notifyListeners();
          },
        );
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await tvSeriesSaveWatchList.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await tvSeriesRemoveWatchlist.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvSeriesWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
