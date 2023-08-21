import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:equatable/equatable.dart';

class SpokenLanguageModel extends Equatable {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  // Convert JSON to SpokenLanguageModel
  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  // Convert SpokenLanguageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }

  // Convert SpokenLanguageModel to SpokenLanguage entity
  SpokenLanguage toEntity() {
    return SpokenLanguage(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }

  @override
  List<Object?> get props => [englishName, iso6391, name];
}
