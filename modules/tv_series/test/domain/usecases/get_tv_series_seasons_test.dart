import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeason usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesSeason(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tTvSeriesSeason = SeasonDetail(episodes: []);

  test('should get list of tv series seasons from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesSeason(
            id: tId, seasonNumber: tSeasonNumber))
        .thenAnswer((_) async => const Right(tTvSeriesSeason));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(tTvSeriesSeason));
  });
}
