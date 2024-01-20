import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';

part 'language_event.dart';
part 'language_state.dart';

@LazySingleton()
class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  final SettingsService _settingsService;

  LanguageBloc(SettingsService settingsService)
      : _settingsService = settingsService,
        super(
          Keys.Blocs.language,
          LanguageInitial(
            settingsService.getCurrentLocale(),
            settingsService.getSupportedLocales(),
          ),
        ) {
    on<LanguageUpdated>(_onLanguageUpdated);
  }

  Future<void> _onLanguageUpdated(
    LanguageUpdated event,
    Emitter<LanguageState> emit,
  ) async {
    if (event.newLanguage.languageCode == state.locale.languageCode) {
      return;
    }

    unawaited(
      _settingsService.setCurrentLocaleLanguageCode(
        event.newLanguage.languageCode,
      ),
    );
    emit(LanguageUpdateSuccess(
      event.newLanguage,
      state.supportedLocales,
    ));
  }
}
