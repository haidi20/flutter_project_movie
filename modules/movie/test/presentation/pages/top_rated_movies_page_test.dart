import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import '../../dummy_data/dummy_objects.dart';

class MockMovieTopRatedBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieTopRatedBloc {}

class TopRatedMovieEventFake extends Fake implements MovieEvent {}

class TopRatedMovieStateFake extends Fake implements MovieState {}

void main() {
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMovieEventFake());
    registerFallbackValue(TopRatedMovieStateFake());
  });

  setUp(() {
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>.value(
      value: mockMovieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Page, Top Rated Movie Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state).thenReturn(Empty());
      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state).thenReturn(Loading());
      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(DataLoaded(testMovieList));

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state).thenReturn(const Error('Error'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
