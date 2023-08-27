import 'package:flutter/material.dart';

class TvSeriesSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-series/search';

  const TvSeriesSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: const Text("TV sesries Search"),
      ),
    );
  }
}
