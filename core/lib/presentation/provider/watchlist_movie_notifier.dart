import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.isEmpty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.isLoading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.isError;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.isLoaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }
}