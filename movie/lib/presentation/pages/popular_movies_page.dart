import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movie';
  const PopularMoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    context.read<MoviePopularBloc>().add(const FetchPopularMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MovieState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataLoaded) {
              final populars = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popular = populars[index];
                  return MovieCard(popular);
                },
                itemCount: populars.length,
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
