import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';

class TvSeriesDetailResponse extends Equatable {
  final TvSeriesDetailModel tvSeriesDetail;

  const TvSeriesDetailResponse({required this.tvSeriesDetail});

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        tvSeriesDetail: TvSeriesDetailModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => tvSeriesDetail.toJson();

  @override
  List<Object> get props => [tvSeriesDetail];
}
