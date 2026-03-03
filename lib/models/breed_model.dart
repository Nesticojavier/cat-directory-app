class BreedModel {
  final String breed;
  final String country;
  final String origin;
  final String coat;
  final String pattern;

  BreedModel({
    required this.breed,
    required this.country,
    required this.origin,
    required this.coat,
    required this.pattern,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      breed: json['breed'] ?? '',
      country: json['country'] ?? '',
      origin: json['origin'] ?? '',
      coat: json['coat'] ?? '',
      pattern: json['pattern'] ?? '',
    );
  }
}
