import 'package:core/data/datasources/api/api_helper.dart';
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:tv_series/data/datasources/db/tv_series_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:tv_series/domain/usecases/get_tv_series_airing_today.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_popular.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';
import 'package:tv_series/domain/usecases/get_tv_series_top_rated.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/tv_series_search_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchListBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(apiHelper: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<ApiHelper>(() => ApiHelper());
  locator.registerLazySingleton(() => DataConnectionChecker());

  // start TV SERIES
  // bloc
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesAiringTodayBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesWatchListBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSeasonBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetTvSeriesAiringToday(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesPopular(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendation(locator()));
  locator.registerLazySingleton(() => GetTvSeriesSeason(locator()));
  locator.registerLazySingleton(() => GetTvSeriesTopRated(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchList(locator()));
  locator.registerLazySingleton(() => TvSeriesSaveWatchList(locator()));
  locator.registerLazySingleton(() => TvSeriesRemoveWatchlist(locator()));
  locator.registerLazySingleton(() => TvSeriesSearch(locator()));

  // repository
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(apiHelper: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<TvSeriesDatabaseHelper>(
      () => TvSeriesDatabaseHelper());

  // end TV SERIES
}
