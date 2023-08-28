import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesSeasonResponse extends Equatable {
  final SeasonDetailModel seasonDetail;

  TvSeriesSeasonResponse({required this.seasonDetail});

  factory TvSeriesSeasonResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonResponse(
        seasonDetail: SeasonDetailModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => seasonDetail.toJson();

  @override
  List<Object> get props => [seasonDetail];
}
