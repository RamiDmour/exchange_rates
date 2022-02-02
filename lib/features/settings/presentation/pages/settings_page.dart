import 'package:exchange_rates/core/utils/exchange_rates_colors.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/exchange_rate_setting.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_event.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = "SettingsPage";

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List<ExchangeRateSetting> _settings = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ExchangeRatesColors.appBarColor,
        actions: [
          IconButton(
            onPressed: () {
              context.read<SettingsBloc>().add(UpdateSettingsEvent(settings: _settings));
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (_settings.isEmpty) {
            _settings = state.settings;
          }

          return ReorderableListView.builder(
            itemBuilder: (context, index) {
              final exchangeRateSetting = _settings[index];
              final currency = exchangeRateSetting.currency;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                key: ValueKey(index),
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(currency.abbreviation),
                        Text(
                          '${currency.scale} ${currency.name}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Switch(
                          activeColor: Colors.grey[500],
                          value: exchangeRateSetting.isVisible,
                          onChanged: (value) {
                            setState(() {
                              _settings[index] = _settings[index].copyWith(isVisible: value);
                            });
                          },
                        ),
                        const Icon(Icons.menu)
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              );
            },
            itemCount: _settings.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final exchangeRateSetting = _settings.removeAt(oldIndex);
                _settings.insert(newIndex, exchangeRateSetting);
              });
            },
          );
        },
      ),
    ));
  }
}
