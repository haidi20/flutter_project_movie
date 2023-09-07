import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    context.read<MovieTopRatedBloc>().add(const FetchTopRatedMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataLoaded) {
              final topRateds = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRated = topRateds[index];
                  return MovieCard(topRated);
                },
                itemCount: topRateds.length,
              );
            } else if (state is Empty) {
              return const Expanded(
                child: Center(
                  child: Text("data tidak ada"),
                ),
              );
            } else if (state is Error) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Expanded(
                child: Center(
                  child: Text("else"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
