import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/usecases/get_tv_series_seasons.dart';
import 'package:core/presentation/provider/tv_series_season_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesSeason])
void main() {
  late MockGetTvSeriesSeason mockGetTvSeriesSeason;
  late TvSeriesSeasonNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesSeason = MockGetTvSeriesSeason();
    notifier = TvSeriesSeasonNotifier(
      getTvSeriesSeason: mockGetTvSeriesSeason,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeriesSeasonDetail = SeasonDetail(
    id_underscore: "5dac967fed28b90014dbbc04",
    id: 134441,
    airDate: "1952-12-26",
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
    episodes: [
      Episode(
        airDate: "1952-12-26",
        episodeNumber: 1,
        episodeType: "standard",
        id: 1958839,
        name: "Episode 1",
        overview: "",
        productionCode: "",
        runtime: 15,
        seasonNumber: 1,
        showId: 94722,
        stillPath: null,
        voteAverage: 1.0,
        voteCount: 2,
        crew: [],
        guestStars: [],
      ),
    ],
  );

  int tId = 1;
  int tSeasonNumber = 1;

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvSeriesSeason.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
    // act
    notifier.fetchSeasonDetailTvSeries(id: tId, seasonNumber: tSeasonNumber);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvSeriesSeason.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
    // act
    await notifier.fetchSeasonDetailTvSeries(
        id: tId, seasonNumber: tSeasonNumber);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeriesSeason, tTvSeriesSeasonDetail);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeriesSeason.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchSeasonDetailTvSeries(
        id: tId, seasonNumber: tSeasonNumber);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
