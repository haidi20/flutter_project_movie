import 'package:tv_series/domain/entities/networks.dart';
import 'package:equatable/equatable.dart';

class NetworksModel extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  NetworksModel({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory NetworksModel.fromJson(Map<String, dynamic> json) {
    return NetworksModel(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  Networks toEntity() {
    return Networks(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
