import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class TvSeriesRemoveWatchlist {
  final TvSeriesRepository repository;

  TvSeriesRemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeriesDetail) {
    return repository.removeWatchlist(tvSeriesDetail);
  }
}
