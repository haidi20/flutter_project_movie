import 'package:tv_series/data/models/season_detail_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesSeasonDetailResponse extends Equatable {
  final SeasonDetailModel seasonDetail;

  const TvSeriesSeasonDetailResponse({required this.seasonDetail});

  factory TvSeriesSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonDetailResponse(
        seasonDetail: SeasonDetailModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => seasonDetail.toJson();

  @override
  List<Object> get props => [seasonDetail];
}
