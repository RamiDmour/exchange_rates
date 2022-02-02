import 'dart:convert';

import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final int id;
  final String abbreviation;
  final int scale;
  final String name;
  const Currency({
    required this.id,
    required this.abbreviation,
    required this.scale,
    required this.name,
  });

  @override
  List<Object> get props => [id, abbreviation, scale, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'abbreviation': abbreviation,
      'scale': scale,
      'name': name,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id']?.toInt() ?? 0,
      abbreviation: map['abbreviation'] ?? '',
      scale: map['scale']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) => Currency.fromMap(json.decode(source));
}
