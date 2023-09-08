import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_airing_today_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_series_popular_page.dart';
import 'package:tv_series/presentation/pages/tv_series_top_rated_page.dart';
import 'package:core/presentation/widgets/drawer_list.dart';
import 'package:flutter/material.dart';
import 'package:search/presentation/pages/tv_series_search_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const routeName = '/tv-series';

  const TvSeriesPage({super.key});

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    Future.microtask(() =>
        context.read<TvSeriesAiringTodayBloc>().add(const FetchAiringToday()));
    Future.microtask(
        () => context.read<TvSeriesPopularBloc>().add(const FetchPopular()));
    Future.microtask(
        () => context.read<TvSeriesTopRatedBloc>().add(const FetchTopRated()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerList(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSeriesSearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () => Navigator.pushNamed(
                    context, TvSeriesAiringTodayPage.routeName),
              ),
              BlocBuilder<TvSeriesAiringTodayBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DataLoaded) {
                    final airingTodays = state.result;

                    return TvSeriesList(airingTodays);
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
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, TvSeriesPopularPage.routeName),
              ),
              BlocBuilder<TvSeriesPopularBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DataLoaded) {
                    final populars = state.result;

                    return TvSeriesList(populars);
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
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TvSeriesTopRatedPage.routeName),
              ),
              BlocBuilder<TvSeriesTopRatedBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DataLoaded) {
                    final topRateds = state.result;

                    return TvSeriesList(topRateds);
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
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesList(this.tvSeriesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.routeName,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
