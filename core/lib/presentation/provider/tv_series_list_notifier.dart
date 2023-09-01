import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_airing_today.dart';
import 'package:core/domain/usecases/get_tv_series_popular.dart';
import 'package:core/domain/usecases/get_tv_series_top_rated.dart';
import 'package:flutter/foundation.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetTvSeriesAiringToday getTvSeriesAiringToday;
  final GetTvSeriesPopular getTvSeriesPopular;
  final GetTvSeriesTopRated getTvSeriesTopRated;

  TvSeriesListNotifier({
    required this.getTvSeriesAiringToday,
    required this.getTvSeriesPopular,
    required this.getTvSeriesTopRated,
  });

  var _airingTodayTvSeries = <TvSeries>[];
  List<TvSeries> get airingTodayTvSeries => _airingTodayTvSeries;
  RequestState _airingTodayState = RequestState.isEmpty;
  RequestState get airingTodayState => _airingTodayState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;
  RequestState _popularState = RequestState.isEmpty;
  RequestState get popularState => _popularState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;
  RequestState _topRatedState = RequestState.isEmpty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchListTvSeries() async {
    _airingTodayState = RequestState.isLoading;
    notifyListeners();

    final result = await getTvSeriesAiringToday.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _airingTodayState = RequestState.isError;
        notifyListeners();
      },
      (tvSeries) {
        _airingTodayTvSeries = tvSeries;
        _airingTodayState = RequestState.isLoaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.isLoading;
    notifyListeners();

    final result = await getTvSeriesPopular.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _popularState = RequestState.isError;
        notifyListeners();
      },
      (tvSeries) {
        _popularTvSeries = tvSeries;
        _popularState = RequestState.isLoaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.isLoading;
    notifyListeners();

    final result = await getTvSeriesTopRated.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _topRatedState = RequestState.isError;
        notifyListeners();
      },
      (tvSeries) {
        _topRatedTvSeries = tvSeries;
        _topRatedState = RequestState.isLoaded;
        notifyListeners();
      },
    );
  }
}
