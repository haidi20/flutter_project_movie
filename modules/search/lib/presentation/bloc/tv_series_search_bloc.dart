import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final TvSeriesSearch _searchTvSeries;

  TvSeriesSearchBloc(this._searchTvSeries) : super(TvSeriesSearchEmpty()) {
    on<TvSeriesOnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSeriesSearchLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(TvSeriesSearchError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(TvSeriesSearchEmpty());
          } else {
            emit(TvSeriesSearchHasData(data));
          }
        },
      );
    }, transformer: debounce(const Duration(microseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
