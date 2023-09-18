import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviePopularBloc extends MockBloc<MovieEvent, MovieState>
    implements MoviePopularBloc {}

class PopularMovieEventFake extends Fake implements MovieEvent {}

class PopularMovieStateFake extends Fake implements MovieState {}

void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUpAll(() {
    registerFallbackValue(PopularMovieEventFake());
    registerFallbackValue(PopularMovieStateFake());
  });

  setUp(() {
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>.value(
      value: mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Page, Popular Movie Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state).thenReturn(Empty());
      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state).thenReturn(Loading());
      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state)
          .thenReturn(DataLoaded(testMovieList));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state).thenReturn(const Error('Error'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
