import 'package:equatable/equatable.dart';
import 'package:exchange_rates/features/exchange_rates/data/models/exchange_rate.dart';

import 'package:exchange_rates/features/exchange_rates/domain/entity/currency.dart';

class ExchangeRate extends Equatable {
  final Currency currency;
  final DateTime date;
  final double rate;

  const ExchangeRate({
    required this.currency,
    required this.date,
    required this.rate,
  });

  factory ExchangeRate.fromModel(ExchangeRateModel exchangeRate) {
    return ExchangeRate(
        currency: Currency(
          abbreviation: exchangeRate.abbreviation,
          id: exchangeRate.id,
          name: exchangeRate.name,
          scale: exchangeRate.scale,
        ),
        date: DateTime.parse(exchangeRate.date),
        rate: exchangeRate.rate);
  }

  @override
  List<Object> get props => [currency, date, rate];
}
