import 'package:core/core.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesSeason {
  final TvSeriesRepository repository;

  GetTvSeriesSeason(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(id, seassonNumber) {
    return repository.getTvSeriesSeason(id: id, seasonNumber: seassonNumber);
  }
}
