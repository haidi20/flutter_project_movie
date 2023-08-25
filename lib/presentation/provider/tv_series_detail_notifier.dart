import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter/foundation.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation getTvSeriesRecommendation;
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;
  final TvSeriesSaveWatchList tvSeriesSaveWatchList;
  final TvSeriesRemoveWatchlist tvSeriesRemoveWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendation,
    required this.getTvSeriesWatchListStatus,
    required this.tvSeriesSaveWatchList,
    required this.tvSeriesRemoveWatchlist,
  });

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  RequestState _tvSeriesDetailState = RequestState.Empty;
  RequestState get tvSeriesDetailState => _tvSeriesDetailState;
  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesRecommendationsState = RequestState.Empty;
  RequestState get getTvSeriesRecommendationState =>
      _tvSeriesRecommendationsState;
  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchDetailTvSeries({required int id}) async {
    _tvSeriesDetailState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendation.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesDetail = tvSeries;
        _tvSeriesDetailState = RequestState.Loaded;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _tvSeriesRecommendationsState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (tvSeries) {
            _tvSeriesRecommendations = tvSeries;
            _tvSeriesRecommendationsState = RequestState.Loaded;
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

    await loadWatchlistStatus(tvSeriesDetail.id ?? 0);
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

    await loadWatchlistStatus(tvSeriesDetail.id ?? 0);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvSeriesWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
