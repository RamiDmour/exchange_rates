import 'package:exchange_rates/features/exchange_rates/data/models/exchange_rate.dart';
import 'package:exchange_rates/features/exchange_rates/data/repositories/exchange_rates_repository.dart';
import 'package:exchange_rates/features/exchange_rates/domain/entity/exchange_rate.dart';

class GetExchangeRates {
  final ExchangeRatesRepoBase _repo;

  GetExchangeRates([ExchangeRatesRepoBase? repo]) : _repo = repo ?? ExchangeRatesRepo();

  Future<List<ExchangeRate>> call(DateTime date) => _repo.getExchangeRates(date);
}
