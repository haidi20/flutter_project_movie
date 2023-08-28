import 'package:about/about.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/tv_series_page.dart';
import 'package:core/presentation/pages/tv_series_watch_list_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv_rounded),
            title: const Text('TV Series'),
            onTap: () {
              Navigator.pushNamed(context, TvSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist movie'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist Tv Series'),
            onTap: () {
              Navigator.pushNamed(context, TvSeriesWatchListPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
