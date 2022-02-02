import 'package:dio/dio.dart';
import 'package:exchange_rates/core/remote/exchange_rates_http_client.dart';
import 'package:exchange_rates/features/exchange_rates/data/models/exchange_rate.dart';

abstract class ExchangeRatesRemoteDataSourceBase {
  Future<List<ExchangeRateModel>> getExchangeRates(DateTime date);
}

class ExchangeRatesRemoteDataSource extends ExchangeRatesRemoteDataSourceBase {
  ExchangeRatesRemoteDataSource({ExchangeRatesHttpClient? httpClient})
      : _httpClient = httpClient ?? ExchangeRatesHttpClient.singleton();

  final ExchangeRatesHttpClient _httpClient;
  @override
  Future<List<ExchangeRateModel>> getExchangeRates(DateTime date) async {
    try {
      Response response = await _httpClient.dio.get(
        'exrates/rates',
        queryParameters: {'onDate': date.toString(), 'periodicity': 0},
      );

      final List<ExchangeRateModel> exchangeRates =
          response.data.map<ExchangeRateModel>((exchangeRate) => ExchangeRateModel.fromMap(exchangeRate)).toList();

      return exchangeRates;
    } on DioError catch (e) {
      // Backend doesn't provide any useful information about errors
      // Checking 500 error which supposed to be recieved in case of missing exchange rates
      if (e.response!.statusCode == 500) {
        return [];
      } else {
        throw Exception(e.message);
      }
    }
  }
}
