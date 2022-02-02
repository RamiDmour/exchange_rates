import 'package:exchange_rates/features/exchange_rates/data/datasources/exchange_rates_remote_datasource.dart';
import 'package:exchange_rates/features/exchange_rates/data/models/exchange_rate.dart';
import 'package:exchange_rates/features/exchange_rates/domain/entity/exchange_rate.dart';

abstract class ExchangeRatesRepoBase {
  Future<List<ExchangeRate>> getExchangeRates(DateTime date);
}

class ExchangeRatesRepo extends ExchangeRatesRepoBase {
  final ExchangeRatesRemoteDataSourceBase _exchangeRatesApi;

  ExchangeRatesRepo([ExchangeRatesRemoteDataSourceBase? exchangeRatesApi])
      : _exchangeRatesApi = exchangeRatesApi ?? ExchangeRatesRemoteDataSource();

  @override
  Future<List<ExchangeRate>> getExchangeRates(DateTime date) async {
    final List<ExchangeRate> exchangeRates = (await _exchangeRatesApi.getExchangeRates(date))
        .map((exchangeRate) => ExchangeRate.fromModel(exchangeRate))
        .toList();

    return exchangeRates;
  }
}
