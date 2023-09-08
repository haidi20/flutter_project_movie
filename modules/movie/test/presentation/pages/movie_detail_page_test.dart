import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieEvent {}

class MovieDetailStateFake extends Fake implements MovieState {}

class MockRecommendationBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommendationBloc {}

class RecommendationEventFake extends Fake implements MovieEvent {}

class RecommendationStateFake extends Fake implements MovieState {}

class MockWatchListBloc extends MockBloc<MovieEvent, MovieState>
    implements WatchListBloc {}

class WatchListEventFake extends Fake implements MovieEvent {}

class WatchListStateFake extends Fake implements MovieState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockRecommendationBloc mockRecommendationBloc;
  late MockWatchListBloc mockWatchListBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockRecommendationBloc = MockRecommendationBloc();
    mockWatchListBloc = MockWatchListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<MovieRecommendationBloc>.value(
            value: mockRecommendationBloc),
        BlocProvider<WatchListBloc>.value(
          value: mockWatchListBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Page, Detail Movie Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(Empty());
      when(() => mockWatchListBloc.state).thenReturn(Empty());
      when(() => mockRecommendationBloc.state).thenReturn(Empty());

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(Loading());
      when(() => mockWatchListBloc.state).thenReturn(Loading());
      // when(() => mockRecommendationMovieBloc.state)
      //     .thenReturn(RecommendationMovieLoadingState());

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display Detail when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const DataDetailLoaded(testMovieDetail));
      when(() => mockWatchListBloc.state)
          .thenReturn(const WatchListStatusLoaded(false));
      when(() => mockRecommendationBloc.state)
          .thenReturn(DataLoaded(testMovieList));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(
        id: testMovieDetail.id,
      )));

      final buttonFinder = find.byType(ElevatedButton);
      final listViewFinder = find.byType(ListView);

      expect(buttonFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(const Error("Error"));
      when(() => mockWatchListBloc.state).thenReturn(const Error("Error"));
      when(() => mockRecommendationBloc.state).thenReturn(const Error('Error'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(
        id: testMovieDetail.id,
      )));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
