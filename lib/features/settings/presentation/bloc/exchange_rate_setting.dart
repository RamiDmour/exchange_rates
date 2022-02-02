import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:exchange_rates/features/exchange_rates/domain/entity/currency.dart';

class ExchangeRateSetting extends Equatable {
  final Currency currency;
  final bool isVisible;
  const ExchangeRateSetting({
    required this.currency,
    required this.isVisible,
  });

  @override
  List<Object> get props => [currency, isVisible];

  Map<String, dynamic> toMap() {
    return {
      'currency': currency.toMap(),
      'isVisible': isVisible,
    };
  }

  factory ExchangeRateSetting.fromMap(Map<String, dynamic> map) {
    return ExchangeRateSetting(
      currency: Currency.fromMap(map['currency']),
      isVisible: map['isVisible'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExchangeRateSetting.fromJson(String source) => ExchangeRateSetting.fromMap(json.decode(source));

  ExchangeRateSetting copyWith({
    Currency? currency,
    bool? isVisible,
  }) {
    return ExchangeRateSetting(
      currency: currency ?? this.currency,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
