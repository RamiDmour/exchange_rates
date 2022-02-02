import 'package:exchange_rates/core/utils/collections_extension.dart';
import 'package:exchange_rates/core/utils/exchange_rates_colors.dart';
import 'package:exchange_rates/features/exchange_rates/domain/entity/exchange_rate.dart';
import 'package:exchange_rates/features/exchange_rates/presentation/bloc/exchange_rates_bloc.dart';
import 'package:exchange_rates/features/exchange_rates/presentation/bloc/exchange_rates_state.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_state.dart';
import 'package:exchange_rates/features/settings/presentation/pages/settings_page.dart';
import 'package:exchange_rates/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExchangeRatesPage extends StatelessWidget {
  const ExchangeRatesPage({Key? key}) : super(key: key);
  static const routeName = "ExchangeRatesPage";

  @override
  Widget build(BuildContext context) {
    return const ExchangeRatesView();
  }
}

class ExchangeRatesView extends StatelessWidget {
  const ExchangeRatesView({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context, ExchangeRatesState state) {
    if (state is ExchangeRatesLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: ExchangeRatesColors.mainLoadingColor,
        ),
      );
    } else if (state is ExchangeRateDataReady) {
      return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          final List<List<ExchangeRate>> exchangeRatesTotal =
              List.generate(state.exchangeRates.length, (index) => List.empty(growable: true));

          for (var setting in settingsState.settings) {
            state.exchangeRates.values.forEachIndexed((exchangeRates, i) {
              if (setting.isVisible) {
                exchangeRatesTotal[i]
                    .add(exchangeRates.firstWhere((exchangeRate) => exchangeRate.currency.id == setting.currency.id));
              }
            });
          }
          final List<DateTime> dates = state.exchangeRates.keys.toList();

          dates.sort();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      const SizedBox(),
                      ...dates.map(
                        (date) => Text(
                          DateFormat('dd.MM.yyyy').format(date),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const TableRow(children: [SizedBox(), SizedBox(), SizedBox()]),
                  ..._buildExchangeRates(exchangeRatesTotal)
                ],
              ),
            ),
          );
        },
      );
    }

    return const Center(child: Text("Не удалось получить курсы валют"));
  }

  List<TableRow> _buildExchangeRates(List<List<ExchangeRate>> exchangeRatesTotal) {
    final List<TableRow> rows = [];
    exchangeRatesTotal.first.forEachIndexed((exchangeRate, i) {
      final currency = exchangeRate.currency;

      rows.add(TableRow(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currency.abbreviation,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${currency.scale} ${currency.name}',
              textAlign: TextAlign.left,
            )
          ],
        ),
        ...exchangeRatesTotal.map((exchangeRates) {
          final exchangeRate = exchangeRates[i];

          return Text(exchangeRate.rate.toString(), textAlign: TextAlign.center);
        }).toList(),
      ]));
    });

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ExchangeRatesColors.appBarColor,
            title: Text(S.of(context).exchangeRates),
            centerTitle: true,
            actions: [
              if (state is ExchangeRateDataReady)
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed(SettingsPage.routeName),
                  icon: const Icon(Icons.settings),
                )
            ],
          ),
          body: _buildBody(context, state),
        );
      }),
    );
  }
}
