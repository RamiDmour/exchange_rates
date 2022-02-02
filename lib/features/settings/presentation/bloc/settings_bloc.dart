import 'package:exchange_rates/features/exchange_rates/domain/entity/exchange_rate.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_event.dart';
import 'package:exchange_rates/features/settings/presentation/bloc/settings_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<InitSettingsEvent>((event, emit) {
      if (state.settings.isEmpty) {
        emit(SettingsState(settings: event.settings));
      }
    });

    on<UpdateSettingsEvent>((event, emit) => emit(state.copyWith(settings: event.settings)));
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) => SettingsState.fromMap(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) => state.toMap();
}
