import 'dart:convert';

import 'package:exchange_rates/features/settings/presentation/bloc/exchange_rate_setting.dart';

class SettingsState {
  final List<ExchangeRateSetting> settings;
  SettingsState({
    this.settings = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'settings': settings.map((x) => x.toMap()).toList(),
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      settings: List<ExchangeRateSetting>.from(map['settings']?.map((x) => ExchangeRateSetting.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) => SettingsState.fromMap(json.decode(source));

  SettingsState copyWith({
    List<ExchangeRateSetting>? settings,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
    );
  }
}
