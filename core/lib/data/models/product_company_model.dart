import 'package:core/domain/entities/product_company.dart';
import 'package:equatable/equatable.dart';

class ProductCompanyModel extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductCompanyModel({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  // Convert a JSON object into a ProductCompanyModel
  factory ProductCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductCompanyModel(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  // Convert a ProductCompanyModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  // Convert a ProductCompanyModel into a ProductCompany entity
  ProductCompany toEntity() {
    return ProductCompany(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
