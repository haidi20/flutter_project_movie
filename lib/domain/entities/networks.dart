import 'package:equatable/equatable.dart';

class Networks extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  Networks({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
