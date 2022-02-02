import 'package:exchange_rates/features/exchange_rates/presentation/bloc/exchange_rates_bloc.dart';
import 'package:exchange_rates/features/exchange_rates/presentation/bloc/exchange_rates_event.dart';
import 'package:exchange_rates/features/exchange_rates/presentation/pages/exchange_rates_page.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:exchange_rates/features/settings/presentation/pages/settings_page.dart';
import 'package:exchange_rates/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ExchangeRatesApp extends StatelessWidget {
  const ExchangeRatesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider(
            create: (context) =>
                ExchangeRatesBloc(settingsBloc: context.read<SettingsBloc>())..add(FetchExchangeRatesEvent())),
      ],
      child: MaterialApp(
        title: 'Exchange rates',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ru', ''),
        ],
        locale: const Locale('ru', ''),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case ExchangeRatesPage.routeName:
              return MaterialPageRoute(builder: (_) => const ExchangeRatesPage());
            case SettingsPage.routeName:
              return MaterialPageRoute(builder: (_) => const SettingsPage());
          }
        },
        initialRoute: ExchangeRatesPage.routeName,
      ),
    );
  }
}
