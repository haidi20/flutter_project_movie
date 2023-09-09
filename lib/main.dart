import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/tv_series_search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_airing_today_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_popular_page.dart';
import 'package:search/presentation/pages/tv_series_search_page.dart';
import 'package:tv_series/presentation/pages/tv_series_top_rated_page.dart';
import 'package:tv_series/presentation/pages/tv_series_watch_list_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_airing_today_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_list_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_popular_notifier.dart';
import 'package:search/presentation/provider/tv_series_search_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_season_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_top_rated_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_watchlist_notifier.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesAiringTodayNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesWatchListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSeasonNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesAiringTodayBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesWatchListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesSeasonBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        // initialRoute: TvSeriesWatchListPage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            // start TV SERIES
            case TvSeriesPage.routeName:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());
            case TvSeriesAiringTodayPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => TvSeriesAiringTodayPage());
            case TvSeriesTopRatedPage.routeName:
              return MaterialPageRoute(builder: (_) => TvSeriesTopRatedPage());
            case TvSeriesPopularPage.routeName:
              return MaterialPageRoute(builder: (_) => TvSeriesPopularPage());
            case TvSeriesWatchListPage.routeName:
              return MaterialPageRoute(builder: (_) => TvSeriesWatchListPage());
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case TvSeriesSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => TvSeriesSearchPage());
            // end TV SERIES
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
