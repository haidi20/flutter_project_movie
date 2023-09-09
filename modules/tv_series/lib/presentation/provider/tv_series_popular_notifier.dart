import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_popular.dart';
import 'package:flutter/foundation.dart';

class TvSeriesPopularNotifier extends ChangeNotifier {
  final GetTvSeriesPopular getTvSeriesPopular;

  TvSeriesPopularNotifier({required this.getTvSeriesPopular});

  RequestState _state = RequestState.isEmpty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _state = RequestState.isLoading;
    notifyListeners();

    final result = await getTvSeriesPopular.execute();
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