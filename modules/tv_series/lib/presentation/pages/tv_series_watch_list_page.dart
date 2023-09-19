import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class TvSeriesWatchListPage extends StatefulWidget {
  static const routeName = '/tv-series/watchlist';

  const TvSeriesWatchListPage({super.key});

  @override
  State<TvSeriesWatchListPage> createState() => _TvSeriesWatchListPageState();
}

class _TvSeriesWatchListPageState extends State<TvSeriesWatchListPage>
    with RouteAware {
  @override
  void initState() {
    Future.microtask(() =>
        context.read<TvSeriesWatchListBloc>().add(const FetchWatchListData()));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvSeriesWatchListBloc>().add(const FetchWatchListData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesWatchListBloc, TvSeriesState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListDataLoaded) {
              final watchLists = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watchList = watchLists[index];
                  return TvSeriesCard(watchList);
                },
                itemCount: watchLists.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
