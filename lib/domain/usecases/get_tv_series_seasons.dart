import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesSeason {
  final TvSeriesRepository repository;

  GetTvSeriesSeason(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(id, seassonNumber) {
    return repository.getTvSeriesSeason(id: id, seasonNumber: seassonNumber);
  }
}
