import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_airing_today_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import "../../dummy_data/dummy_objects.dart";

class MockAiringTodayBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesAiringTodayBloc {}

class AiringTodayEventFake extends Fake implements TvSeriesEvent {}

class AiringTodayStateFake extends Fake implements TvSeriesState {}

void main() {
  late MockAiringTodayBloc mockAiringTodayBloc;

  setUpAll(() {
    registerFallbackValue(AiringTodayEventFake());
    registerFallbackValue(AiringTodayStateFake());
  });

  setUp(() {
    mockAiringTodayBloc = MockAiringTodayBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesAiringTodayBloc>.value(
      value: mockAiringTodayBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Page, Airing Today Tv Series Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state).thenReturn(Empty());
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesAiringTodayPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state).thenReturn(Loading());
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesAiringTodayPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state)
          .thenReturn(DataLoaded(testTvSeriesList));

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesAiringTodayPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state).thenReturn(const Error('Error'));

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesAiringTodayPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
