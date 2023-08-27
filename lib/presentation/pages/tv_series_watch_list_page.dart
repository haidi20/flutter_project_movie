import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/tv_series_watchlist_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesWatchListPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/watchlist';

  @override
  _TvSeriesWatchListPageState createState() => _TvSeriesWatchListPageState();
}

class _TvSeriesWatchListPageState extends State<TvSeriesWatchListPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvSeriesWatchListNotifier>(context, listen: false)
            .fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<TvSeriesWatchListNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesWatchListNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.watchlistTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.watchlistTvSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
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
