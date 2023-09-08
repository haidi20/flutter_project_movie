import 'package:core/utils/network_info.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
