import 'package:ditonton/data/models/episod_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonDetailModel = SeasonDetailModel(
    id_underscore: "5dac967fed28b90014dbbc04",
    id: 134441,
    airDate: "1952-12-26",
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
    episodes: [
      EpisodeModel(
        airDate: "1952-12-26",
        episodeNumber: 1,
        episodeType: "standard",
        id: 1958839,
        name: "Episode 1",
        overview: "",
        productionCode: "",
        runtime: 15,
        seasonNumber: 1,
        showId: 94722,
        stillPath: null,
        voteAverage: 1.0,
        voteCount: 2,
        crew: [],
        guestStars: [],
      ),
    ],
  );

  final tSeasonDetail = SeasonDetail(
    id_underscore: "5dac967fed28b90014dbbc04",
    id: 134441,
    airDate: "1952-12-26",
    name: "Season 1952",
    overview: "",
    posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
    seasonNumber: 1,
    voteAverage: 3.5,
    episodes: [
      Episode(
        airDate: "1952-12-26",
        episodeNumber: 1,
        episodeType: "standard",
        id: 1958839,
        name: "Episode 1",
        overview: "",
        productionCode: "",
        runtime: 15,
        seasonNumber: 1,
        showId: 94722,
        stillPath: null,
        voteAverage: 1.0,
        voteCount: 2,
        crew: [],
        guestStars: [],
      ),
    ],
  );

  test('should be a subclass of Tv Series season entity', () async {
    final result = tSeasonDetailModel.toEntity();
    expect(result, tSeasonDetail);
  });
}
