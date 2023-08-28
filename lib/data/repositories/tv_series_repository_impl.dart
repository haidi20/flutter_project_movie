import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getAiringToday() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAiringToday();
        localDataSource.cacheAiringToday(
            result.map((tvSeries) => TvSeriesTable.fromDTO(tvSeries)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedAiringToday();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchList() async {
    final result = await localDataSource.getWatchList();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopular() async {
    try {
      final result = await remoteDataSource.getPopular();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRated() async {
    try {
      final result = await remoteDataSource.getTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SeasonDetail>> getTvSeriesSeason(
      {required int id, required int seasonNumber}) async {
    try {
      final result = await remoteDataSource.getTvSeriesSeason(
          id: id, seasonNumber: seasonNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendation(
      {required int id}) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendation(id: id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(
      {required int id}) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id: id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(
      TvSeriesDetail tvSeriesDetail) async {
    try {
      final result = await localDataSource
          .insertWatchList(TvSeriesTable.fromEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvSeriesDetail tvSeriesDetail) async {
    try {
      final result = await localDataSource
          .removeWatchlist(TvSeriesTable.fromEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
