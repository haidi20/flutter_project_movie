import 'package:tv_series/domain/entities/production_company.dart';
import 'package:equatable/equatable.dart';

class ProductionCompanyModel extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const ProductionCompanyModel({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  // Convert a JSON object into a ProductionCompanyModel
  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  // Convert a ProductionCompanyModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  // Convert a ProductionCompanyModel into a ProductCompany entity
  ProductionCompany toEntity() {
    return ProductionCompany(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
