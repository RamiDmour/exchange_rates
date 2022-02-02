import 'package:exchange_rates/core/utils/date_time_extensions.dart';
import 'package:exchange_rates/features/exchange_rates/data/repositories/exchange_rates_repository.dart';
import 'package:exchange_rates/features/exchange_rates/domain/entity/exchange_rate.dart';
import 'package:exchange_rates/features/exchange_rates/domain/usercase/get_exchange_rates.dart';
import 'package:exchange_rates/features/exchange_rates/presentation/bloc/exchange_rates_event.dart';
import 'package:exchange_rates/features/exchange_rates/presentation/bloc/exchange_rates_state.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/exchange_rate_setting.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRatesBloc extends Bloc<ExchangeRatesEvent, ExchangeRatesState> {
  final ExchangeRatesRepoBase _exchangeRatesRepo;
  ExchangeRatesBloc({required SettingsBloc settingsBloc, ExchangeRatesRepoBase? exchangeRatesRepo})
      : _exchangeRatesRepo = exchangeRatesRepo ?? ExchangeRatesRepo(),
        super(ExchangeRatesLoading()) {
    on<FetchExchangeRatesEvent>((event, emit) async {
      try {
        emit(ExchangeRatesLoading());

        final Map<DateTime, List<ExchangeRate>> exchangeRatesTotal = {};
        final getExchangeRates = GetExchangeRates(_exchangeRatesRepo);

        final DateTime today = YTTDateTimeExtension.today;
        List<ExchangeRate> exchangeRates = await getExchangeRates(today);

        if (exchangeRates.isEmpty) {
          emit(ExchangeRatesError());
          return;
        }

        exchangeRatesTotal[today] = exchangeRates;

        final tomorrow = YTTDateTimeExtension.tomorrow;
        exchangeRates = await getExchangeRates(tomorrow);

        if (exchangeRates.isNotEmpty) {
          exchangeRatesTotal[tomorrow] = exchangeRates;
        } else {
          final yesterday = YTTDateTimeExtension.yesterday;
          exchangeRatesTotal[yesterday] = await getExchangeRates(yesterday);
        }

        settingsBloc.add(
          InitSettingsEvent(
            settings: exchangeRatesTotal.values.first
                .map(
                  (exchangeRate) => ExchangeRateSetting(
                    currency: exchangeRate.currency,
                    isVisible: exchangeRate.currency.abbreviation == 'USD' ||
                        exchangeRate.currency.abbreviation == 'EUR' ||
                        exchangeRate.currency.abbreviation == 'RUB',
                  ),
                )
                .toList(),
          ),
        );
        emit(ExchangeRateDataReady(exchangeRatesTotal));
      } catch (e) {
        emit(ExchangeRatesError());
        debugPrint(e.toString());
      }
    });
  }
}
