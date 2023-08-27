import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_airing_today.dart';
import 'package:ditonton/domain/usecases/get_tv_series_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_series_top_rated.dart';
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
  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;
  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;
  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchListTvSeries() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesAiringToday.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _airingTodayState = RequestState.Error;
        notifyListeners();
      },
      (tvSeries) {
        _airingTodayTvSeries = tvSeries;
        _airingTodayState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesPopular.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _popularState = RequestState.Error;
        notifyListeners();
      },
      (tvSeries) {
        _popularTvSeries = tvSeries;
        _popularState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesTopRated.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _topRatedState = RequestState.Error;
        notifyListeners();
      },
      (tvSeries) {
        _topRatedTvSeries = tvSeries;
        _topRatedState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
