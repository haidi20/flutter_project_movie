import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/pages/tv_series_popular_page.dart';

import "../../dummy_data/dummy_objects.dart";

class MockPopularBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesPopularBloc {}

class PopularEventFake extends Fake implements TvSeriesEvent {}

class PopularStateFake extends Fake implements TvSeriesState {}

void main() {
  late MockPopularBloc mockPopularBloc;

  setUpAll(() {
    registerFallbackValue(PopularEventFake());
    registerFallbackValue(PopularStateFake());
  });

  setUp(() {
    mockPopularBloc = MockPopularBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesPopularBloc>.value(
      value: mockPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Page, Popular Tv Series Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockPopularBloc.state).thenReturn(Empty());
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularBloc.state).thenReturn(Loading());
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularBloc.state)
          .thenReturn(DataLoaded(testTvSeriesList));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockPopularBloc.state).thenReturn(const Error('Error'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
