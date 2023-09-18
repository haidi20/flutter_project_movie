import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_page.dart';
import 'package:http/http.dart' as http;

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

class MockAiringTodayBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesAiringTodayBloc {}

class AiringTodayEventFake extends Fake implements TvSeriesEvent {}

class AiringTodayStateFake extends Fake implements TvSeriesState {}

class MockPopularBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesPopularBloc {}

class PopularEventFake extends Fake implements TvSeriesEvent {}

class PopularStateFake extends Fake implements TvSeriesState {}

class MockTopRatedBloc extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TvSeriesTopRatedBloc {}

class TopRatedEventFake extends Fake implements TvSeriesEvent {}

class TopRatedStateFake extends Fake implements TvSeriesState {}

void main() {
  late MockAiringTodayBloc mockAiringTodayBloc;
  late MockPopularBloc mockPopularBloc;
  late MockTopRatedBloc mockTopRatedBloc;
  late MockHttpClient mockHttpClient;
  // final client = MockHttpClient();

  setUpAll(() {
    registerFallbackValue(AiringTodayEventFake());
    registerFallbackValue(AiringTodayStateFake());
    registerFallbackValue(PopularEventFake());
    registerFallbackValue(PopularStateFake());
    registerFallbackValue(TopRatedEventFake());
    registerFallbackValue(TopRatedStateFake());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockAiringTodayBloc = MockAiringTodayBloc();
    mockPopularBloc = MockPopularBloc();
    mockTopRatedBloc = MockTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesAiringTodayBloc>.value(value: mockAiringTodayBloc),
        BlocProvider<TvSeriesPopularBloc>.value(value: mockPopularBloc),
        BlocProvider<TvSeriesTopRatedBloc>.value(
          value: mockTopRatedBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Page, Tv Series Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state).thenReturn(Empty());
      when(() => mockPopularBloc.state).thenReturn(Empty());
      when(() => mockTopRatedBloc.state).thenReturn(Empty());

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    // testWidgets('page should display center progress bar when loading',
    //     (WidgetTester tester) async {
    //   when(() => mockAiringTodayBloc.state).thenReturn(Loading());
    //   when(() => mockPopularBloc.state).thenReturn(Loading());
    //   when(() => mockTopRatedBloc.state).thenReturn(Loading());

    //   await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

    //   // final progressBarFinder = find.byType(CircularProgressIndicator);
    //   final centerFinder = find.byType(Center);

    //   expect(centerFinder, findsNWidgets(3));
    //   // expect(progressBarFinder, findsNWidgets(3));
    // });

    // testWidgets('page should display when data is loaded',
    //     (WidgetTester tester) async {
    //   when(() => mockAiringTodayBloc.state)
    //       .thenReturn(DataLoaded(testTvSeriesList));
    //   when(() => mockPopularBloc.state)
    //       .thenReturn(DataLoaded(testTvSeriesList));
    //   when(() => mockTopRatedBloc.state)
    //       .thenReturn(DataLoaded(testTvSeriesList));

    //   await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
    //   // Setelah membangun widget, Anda mungkin ingin menunggu sampai frame selesai dirender
    //   await tester.pumpAndSettle();
    //   await tester.pump();

    //   final listViewFinder = find.byType(ListView);
    //   expect(listViewFinder, findsOneWidget);
    // });

    //   testWidgets('page should display text with message when Error',
    //       (WidgetTester tester) async {
    //     when(() => mockAiringTodayBloc.state).thenReturn(const Error("Error"));
    //     when(() => mockPopularBloc.state).thenReturn(const Error("Error"));
    //     when(() => mockTopRatedBloc.state).thenReturn(const Error('Error'));

    //     await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

    //     final textFinder = find.byKey(const Key('error_message'));
    //     expect(textFinder, findsOneWidget);
    //   });
  });
}
