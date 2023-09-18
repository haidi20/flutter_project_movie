import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/pages/tv_series_watch_list_page.dart';
import "../../dummy_data/dummy_objects.dart";

class MockWatchListBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesWatchListBloc {}

class WatchListEventFake extends Fake implements TvSeriesEvent {}

class WatchListStateFake extends Fake implements TvSeriesState {}

void main() {
  late MockWatchListBloc mockWatchListBloc;

  setUpAll(() {
    registerFallbackValue(WatchListEventFake());
    registerFallbackValue(WatchListStateFake());
  });

  setUp(() {
    mockWatchListBloc = MockWatchListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesWatchListBloc>.value(
      value: mockWatchListBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Page, Watch List Tv Series Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockWatchListBloc.state).thenReturn(Empty());
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesWatchListPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockWatchListBloc.state).thenReturn(Loading());
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesWatchListPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockWatchListBloc.state)
          .thenReturn(DataLoaded(testTvSeriesList));

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesWatchListPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockWatchListBloc.state).thenReturn(const Error('Error'));

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesWatchListPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
