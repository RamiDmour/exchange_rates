import 'dart:convert';

class ExchangeRateModel {
  final int id;
  final String date;
  final String abbreviation;
  final int scale;
  final String name;
  final double rate;
  ExchangeRateModel({
    required this.id,
    required this.date,
    required this.abbreviation,
    required this.scale,
    required this.name,
    required this.rate,
  });

  ExchangeRateModel copyWith({
    int? id,
    String? date,
    String? abbreviation,
    int? scale,
    String? name,
    double? rate,
  }) {
    return ExchangeRateModel(
      id: id ?? this.id,
      date: date ?? this.date,
      abbreviation: abbreviation ?? this.abbreviation,
      scale: scale ?? this.scale,
      name: name ?? this.name,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Cur_ID': id,
      'Date': date,
      'Cur_Abbreviation': abbreviation,
      'Cur_Scale': scale,
      'Cur_Name': name,
      'Cur_OfficialRate': rate,
    };
  }

  factory ExchangeRateModel.fromMap(Map<String, dynamic> map) {
    return ExchangeRateModel(
      id: map['Cur_ID']?.toInt() ?? 0,
      date: map['Date'] ?? '',
      abbreviation: map['Cur_Abbreviation'] ?? '',
      scale: map['Cur_Scale']?.toInt() ?? 0,
      name: map['Cur_Name'] ?? '',
      rate: map['Cur_OfficialRate']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExchangeRateModel.fromJson(String source) => ExchangeRateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExchangeRate(Cur_ID: $id, Date: $date, Cur_Abbreviation: $abbreviation, Cur_Scale: $scale, Cur_Name: $name, Cur_OfficialRate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExchangeRateModel &&
        other.id == id &&
        other.date == date &&
        other.abbreviation == abbreviation &&
        other.scale == scale &&
        other.name == name &&
        other.rate == rate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ abbreviation.hashCode ^ scale.hashCode ^ name.hashCode ^ rate.hashCode;
  }
}
