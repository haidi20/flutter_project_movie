import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class TvSeriesTopRatedPage extends StatefulWidget {
  static const routeName = '/tv-series/top-rated';

  const TvSeriesTopRatedPage({super.key});

  @override
  State<TvSeriesTopRatedPage> createState() => _TvSeriesTopRatedPageState();
}

class _TvSeriesTopRatedPageState extends State<TvSeriesTopRatedPage> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<TvSeriesTopRatedBloc>().add(const FetchTopRated()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataLoaded) {
              final topRateds = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popular = topRateds[index];
                  return TvSeriesCard(popular);
                },
                itemCount: topRateds.length,
              );
            } else if (state is Empty) {
              return const Center(
                child: Text("data tidak ada"),
              );
            } else if (state is Error) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
