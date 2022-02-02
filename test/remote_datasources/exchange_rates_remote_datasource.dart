import 'package:exchange_rates/core/remote/exchange_rates_http_client.dart';
import 'package:exchange_rates/features/exchange_rates/data/datasources/exchange_rates_remote_datasource.dart';
import 'package:exchange_rates/features/exchange_rates/data/models/exchange_rate.dart';
import 'package:test/test.dart';

void main() {
  group('exchange rate remote data source', () {
    late ExchangeRatesHttpClient httpClient;
    late ExchangeRatesRemoteDataSourceBase apiClient;

    setUpAll(() {
      httpClient = ExchangeRatesHttpClient.singleton();
      apiClient = ExchangeRatesRemoteDataSource(httpClient: httpClient);
    });
    group('getExchangeRate', () {
      test('return ExchangeRate', () async {
        final List<ExchangeRateModel> exchangeRates = await apiClient.getExchangeRates(DateTime.now());
        expect(exchangeRates.length, isNot(0));
      });

      test('null behavior', () async {
        final List<ExchangeRateModel> exchangeRates = await apiClient.getExchangeRates(DateTime.parse('0001-01-01'));
        expect(exchangeRates.length, equals(0));
      });
    });
  });
}
