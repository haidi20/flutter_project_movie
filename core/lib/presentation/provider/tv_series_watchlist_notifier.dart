import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_watchlist.dart';
import 'package:flutter/foundation.dart';

class TvSeriesWatchListNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistState = RequestState.isEmpty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  TvSeriesWatchListNotifier({required this.getTvseriesWatchlist});

  final GetTvSeriesWatchList getTvseriesWatchlist;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.isLoading;
    notifyListeners();

    final result = await getTvseriesWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.isError;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistState = RequestState.isLoaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
