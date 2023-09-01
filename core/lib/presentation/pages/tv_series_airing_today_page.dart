import 'package:core/core.dart';
import 'package:core/presentation/provider/tv_series_airing_today_notifier.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesAiringTodayPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/airing-today';

  const TvSeriesAiringTodayPage({super.key});

  @override
  State<TvSeriesAiringTodayPage> createState() =>
      _TvSeriesAiringTodayPageState();
}

class _TvSeriesAiringTodayPageState extends State<TvSeriesAiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvSeriesAiringTodayNotifier>(context, listen: false)
            .fetchAiringTodayTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesAiringTodayNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.isLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
