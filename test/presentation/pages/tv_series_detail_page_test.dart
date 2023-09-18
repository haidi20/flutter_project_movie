import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesDetailBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesDetailBloc {}

class TvSeriesDetailEventFake extends Fake implements TvSeriesEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesState {}

class MockRecommendationBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesRecommendationBloc {}

class RecommendationEventFake extends Fake implements TvSeriesEvent {}

class RecommendationStateFake extends Fake implements TvSeriesState {}

class MockWatchListBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesWatchListBloc {}

class WatchListEventFake extends Fake implements TvSeriesEvent {}

class WatchListStateFake extends Fake implements TvSeriesState {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockRecommendationBloc mockRecommendationBloc;
  late MockWatchListBloc mockWatchListBloc;

  setUpAll(() {
    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
    registerFallbackValue(RecommendationEventFake());
    registerFallbackValue(RecommendationStateFake());
    registerFallbackValue(WatchListEventFake());
    registerFallbackValue(WatchListStateFake());
  });

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockRecommendationBloc = MockRecommendationBloc();
    mockWatchListBloc = MockWatchListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>.value(value: mockTvSeriesDetailBloc),
        BlocProvider<TvSeriesRecommendationBloc>.value(
            value: mockRecommendationBloc),
        BlocProvider<TvSeriesWatchListBloc>.value(
          value: mockWatchListBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Page, Detail Tv Series Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(Empty());
      when(() => mockWatchListBloc.state).thenReturn(Empty());
      when(() => mockRecommendationBloc.state).thenReturn(Empty());

      await tester.pumpWidget(
          makeTestableWidget(TvSeriesDetailPage(id: testTvSeriesDetail.id)));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(Loading());
      when(() => mockWatchListBloc.state).thenReturn(Loading());
      when(() => mockRecommendationBloc.state).thenReturn(Loading());

      await tester.pumpWidget(
          makeTestableWidget(TvSeriesDetailPage(id: testTvSeriesDetail.id)));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    // testWidgets('page should display Detail when data is loaded',
    //     (WidgetTester tester) async {
    //   when(() => mockTvSeriesDetailBloc.state)
    //       .thenReturn(DataDetailLoaded(testTvSeriesDetail, testSeasonList));
    //   when(() => mockWatchListBloc.state)
    //       .thenReturn(const WatchListStatusLoaded(false));
    //   when(() => mockRecommendationBloc.state)
    //       .thenReturn(DataLoaded(testTvSeriesList));

    //   await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(
    //     id: testTvSeries.id,
    //   )));

    //   final buttonFinder = find.byType(ElevatedButton);
    //   expect(buttonFinder, findsOneWidget);

    //   final listViewFinder = find.byType(ListView);
    //   expect(listViewFinder, findsOneWidget);
    // });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(const Error("Error"));
      when(() => mockWatchListBloc.state).thenReturn(const Error("Error"));
      when(() => mockRecommendationBloc.state).thenReturn(const Error('Error'));

      await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(
        id: testTvSeriesDetail.id,
      )));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
