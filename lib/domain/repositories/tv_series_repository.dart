import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_series_model.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeriesModel>>> getAiringTodayTvSeries();
}
