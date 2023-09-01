import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesWatchList {
  final TvSeriesRepository repository;

  GetTvSeriesWatchList(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getWatchList();
  }
}
