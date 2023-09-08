import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class TvSeriesAiringTodayPage extends StatefulWidget {
  static const routeName = '/tv-series/airing-today';

  const TvSeriesAiringTodayPage({super.key});

  @override
  State<TvSeriesAiringTodayPage> createState() =>
      _TvSeriesAiringTodayPageState();
}

class _TvSeriesAiringTodayPageState extends State<TvSeriesAiringTodayPage> {
  @override
  void initState() {
    Future.microtask(() =>
        context.read<TvSeriesAiringTodayBloc>().add(const FetchAiringToday()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesAiringTodayBloc, TvSeriesState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataLoaded) {
              final airingTodays = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popular = airingTodays[index];
                  return TvSeriesCard(popular);
                },
                itemCount: airingTodays.length,
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
