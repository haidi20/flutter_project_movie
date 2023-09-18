import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  MovieDatabaseHelper,
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesDatabaseHelper,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
