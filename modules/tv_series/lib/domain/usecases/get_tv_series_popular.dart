import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesPopular {
  final TvSeriesRepository repository;

  GetTvSeriesPopular(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopular();
  }
}
