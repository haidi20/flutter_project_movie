import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_popular.dart';
import 'package:ditonton/presentation/provider/tv_series_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_popular_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesPopular])
void main() {
  late MockGetTvSeriesPopular mockGetTvSeriesTopRated;
  late TvSeriesPopularNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesTopRated = MockGetTvSeriesPopular();
    notifier = TvSeriesPopularNotifier(
      getTvSeriesPopular: mockGetTvSeriesTopRated,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = TvSeries(
    id: 94722,
    name: "Tagesschau",
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    backdropPath: 'path/to/backdrop.jpg',
    firstAirDate: '2023-08-23',
    genreIds: [1, 2, 3],
    originCountry: ['US', 'UK'],
    originalLanguage: 'English',
    originalName: 'Original Name',
    popularity: 7.8,
    voteAverage: 7.5,
    voteCount: 1000,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvSeriesTopRated.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvSeriesTopRated.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeriesTopRated.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
