import 'package:exchange_rates/features/settings/presentation/bloc/exchange_rate_setting.dart';

abstract class SettingsEvent {}

class UpdateSettingsEvent extends SettingsEvent {
  final List<ExchangeRateSetting> settings;

  UpdateSettingsEvent({
    required this.settings,
  });
}

class InitSettingsEvent extends SettingsEvent {
  final List<ExchangeRateSetting> settings;

  InitSettingsEvent({
    required this.settings,
  });
}
