import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringToday();
  Future<Either<Failure, List<TvSeries>>> getWatchList();
  Future<Either<Failure, List<TvSeries>>> getPopular();
  Future<Either<Failure, List<TvSeries>>> getTopRated();
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendation(
      {required int id});
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail({required int id});
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeriesDetail);
  Future<Either<Failure, String>> removeWatchlist(
    TvSeriesDetail tvSeriesDetail,
  );
  Future<bool> isAddedToWatchlist(int id);
}
