import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_seasons.dart';
import 'package:flutter/foundation.dart';

class TvSeriesSeasonNotifier extends ChangeNotifier {
  final GetTvSeriesSeason getTvSeriesSeason;

  TvSeriesSeasonNotifier({required this.getTvSeriesSeason});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  SeasonDetail _tvSeriesSeason = SeasonDetail(episodes: []);
  SeasonDetail get tvSeriesSeason => _tvSeriesSeason;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetailTvSeries(
      {required int id, required int seasonNumber}) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesSeason.execute(id, seasonNumber);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesSeason) {
        _tvSeriesSeason = tvSeriesSeason;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
