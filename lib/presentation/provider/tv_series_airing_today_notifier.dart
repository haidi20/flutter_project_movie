import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_airing_today.dart';
import 'package:flutter/foundation.dart';

class TvSeriesAiringTodayNotifier extends ChangeNotifier {
  final GetTvSeriesAiringToday getTvSeriesAiringToday;

  TvSeriesAiringTodayNotifier({required this.getTvSeriesAiringToday});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesAiringToday.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeries = tvSeries;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
