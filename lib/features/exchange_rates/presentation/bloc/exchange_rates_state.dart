import 'package:equatable/equatable.dart';

import 'package:exchange_rates/features/exchange_rates/domain/entity/exchange_rate.dart';

abstract class ExchangeRatesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExchangeRatesLoading extends ExchangeRatesState {}

class ExchangeRateDataReady extends ExchangeRatesState {
  final Map<DateTime, List<ExchangeRate>> exchangeRates;

  ExchangeRateDataReady(this.exchangeRates);

  ExchangeRateDataReady copyWith({
    Map<DateTime, List<ExchangeRate>>? exchangeRates,
  }) {
    return ExchangeRateDataReady(
      exchangeRates ?? this.exchangeRates,
    );
  }
}

class ExchangeRatesError extends ExchangeRatesState {}
