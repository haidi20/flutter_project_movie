import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import '../../domain/usecases/search_tv_series.dart';
import 'package:flutter/foundation.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final TvSeriesSearch searchTvSeries;

  TvSeriesSearchNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.isEmpty;
  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];
  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchTvSeries(String query) async {
    _state = RequestState.isLoading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.isError;
        notifyListeners();
      },
      (data) {
        _tvSeriesList = data;
        _state = RequestState.isLoaded;
        notifyListeners();
      },
    );
  }
}
