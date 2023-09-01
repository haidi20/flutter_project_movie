import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesPopular {
  final TvSeriesRepository repository;

  GetTvSeriesPopular(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopular();
  }
}
