import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/pages/tv_series_top_rated_page.dart';
import "../../dummy_data/dummy_objects.dart";

class MockTopRatedBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesTopRatedBloc {}

class TopRatedEventFake extends Fake implements TvSeriesEvent {}

class TopRatedStateFake extends Fake implements TvSeriesState {}

void main() {
  late MockTopRatedBloc mockTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedEventFake());
    registerFallbackValue(TopRatedStateFake());
  });

  setUp(() {
    mockTopRatedBloc = MockTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesTopRatedBloc>.value(
      value: mockTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Page, Top Rated Tv Series Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockTopRatedBloc.state).thenReturn(Empty());
      await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockTopRatedBloc.state).thenReturn(Loading());
      await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTopRatedBloc.state).thenReturn(DataLoaded(tvSeriesList));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTopRatedBloc.state).thenReturn(const Error('Error'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
