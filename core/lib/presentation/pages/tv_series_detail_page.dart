import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/presentation/provider/tv_series_detail_notifier.dart';
import 'package:core/presentation/provider/tv_series_season_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/detail';

  final int id;
  const TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .fetchTvSeriesDetail(id: widget.id);
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesDetailState == RequestState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesDetailState == RequestState.isLoaded) {
            final tvSeriesDetail = provider.tvSeriesDetail;
            return SafeArea(
              child: DetailContent(
                tvSeriesid: widget.id,
                tvSeriesDetail: tvSeriesDetail,
                recommendations: provider.tvSeriesRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
                seasons: provider.tvSeriesSeasons,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final int tvSeriesid;
  final TvSeriesDetail tvSeriesDetail;
  final List<TvSeries> recommendations;
  final List<Season> seasons;
  final bool isAddedWatchlist;

  DetailContent({
    required this.tvSeriesid,
    required this.tvSeriesDetail,
    required this.recommendations,
    required this.seasons,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name ?? "",
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(tvSeriesDetail);
                                } else {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(tvSeriesDetail);
                                }

                                final message =
                                    Provider.of<TvSeriesDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        TvSeriesDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvSeriesDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres ?? []),
                            ),
                            // Text(
                            //   _showDuration(tvSeriesDetail.runtime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage ?? 0.0 / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    "Total Season: ${tvSeriesDetail.numberOfSeasons}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    "Total Episode: ${tvSeriesDetail.numberOfEpisodes}"),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview ?? "",
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            _listSeason(tvSeriesId: tvSeriesid),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _listRecommendation(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _listSeason({required int tvSeriesId}) {
    return Consumer<TvSeriesDetailNotifier>(
      builder: (context, data, child) {
        if (data.tvSeriesDetailState == RequestState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.tvSeriesDetailState == RequestState.isError) {
          return Text(data.message);
        } else if (data.tvSeriesDetailState == RequestState.isLoaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvSeriesSeason = seasons[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      final getTvSeriesSeason = seasons[index];
                      debugPrint(index.toString());
                      Provider.of<TvSeriesSeasonNotifier>(
                        context,
                        listen: false,
                      ).fetchSeasonDetailTvSeries(
                        id: tvSeriesId,
                        seasonNumber: getTvSeriesSeason.seasonNumber,
                      );

                      _showDialogSearch(context: context);
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tvSeriesSeason.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: seasons.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _listRecommendation() {
    return Consumer<TvSeriesDetailNotifier>(
      builder: (context, data, child) {
        if (data.getTvSeriesRecommendationState == RequestState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.getTvSeriesRecommendationState ==
            RequestState.isError) {
          return Text(data.message);
        } else if (data.getTvSeriesRecommendationState ==
            RequestState.isLoaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvSeriesRecommendation = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TvSeriesDetailPage.ROUTE_NAME,
                        arguments: tvSeriesRecommendation.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tvSeriesRecommendation.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future _showDialogSearch({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Episodes'),
          content: SizedBox(
            width: double.maxFinite,
            child: _tvSeriesSeasonCard(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _tvSeriesSeasonCard() {
    return Consumer<TvSeriesSeasonNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.isLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              Episode episode = data.tvSeriesSeason.episodes[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: InkWell(
                  onTap: () {
                    //
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Card(
                        child: Container(
                          margin: const EdgeInsets.only(
                            // left: 16 + 80 + 16,
                            left: 16,
                            bottom: 8,
                            right: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                episode.name ?? '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kHeading6,
                              ),
                              Text(
                                "Episode : ${episode.episodeNumber.toString()}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kHeading6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: data.tvSeriesSeason.episodes.length,
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
