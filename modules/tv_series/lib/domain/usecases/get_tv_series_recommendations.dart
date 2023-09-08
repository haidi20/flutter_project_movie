import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesRecommendation {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendation(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommendation(id: id);
  }
}
