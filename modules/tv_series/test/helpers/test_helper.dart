import 'package:core/utils/network_info.dart';
import 'package:tv_series/data/datasources/db/tv_series_database_helper.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvSeriesDatabaseHelper,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
