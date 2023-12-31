import 'package:tv_series/domain/entities/network.dart';
import 'package:equatable/equatable.dart';

class NetworkModel extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const NetworkModel({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
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

  Network toEntity() {
    return Network(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
