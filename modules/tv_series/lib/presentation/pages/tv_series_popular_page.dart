import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class TvSeriesPopularPage extends StatefulWidget {
  static const routeName = '/tv-series/popular';

  const TvSeriesPopularPage({super.key});

  @override
  State<TvSeriesPopularPage> createState() => _TvSeriesPopularPageState();
}

class _TvSeriesPopularPageState extends State<TvSeriesPopularPage> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<TvSeriesPopularBloc>().add(const FetchPopular()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesState>(
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
                  return TvSeriesCard(popular);
                },
                itemCount: populars.length,
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
