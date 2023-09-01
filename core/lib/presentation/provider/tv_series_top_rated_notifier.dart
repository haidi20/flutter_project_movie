import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_top_rated.dart';
import 'package:flutter/foundation.dart';

class TvSeriesTopRatedNotifier extends ChangeNotifier {
  GetTvSeriesTopRated getTvSeriesTopRated;

  TvSeriesTopRatedNotifier({required this.getTvSeriesTopRated});

  RequestState _state = RequestState.isEmpty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.isLoading;
    notifyListeners();

    final result = await getTvSeriesTopRated.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.isError;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeries = tvSeries;
        _state = RequestState.isLoaded;
        notifyListeners();
      },
    );
  }
}
