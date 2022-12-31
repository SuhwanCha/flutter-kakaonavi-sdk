import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'navi_event.dart';
part 'navi_state.dart';

class NaviBloc extends Bloc<NaviEvent, NaviState> {
  NaviBloc() : super(NaviNotInitial()) {
    on<NaviInitialized>(_onNaviInitialized);
    on<NaviGuideStarted>(_onNaviGuideStarted);
  }

  FutureOr<void> _onNaviInitialized(
      NaviInitialized event, Emitter<NaviState> emit) {
    emit(NaviSuccess(channel: event.channel));
  }

  FutureOr<void> _onNaviGuideStarted(
      NaviGuideStarted event, Emitter<NaviState> emit) {
    final state = this.state;
    if (state is NaviSuccess) {
      state.channel.invokeMethod('startGuide', <String, dynamic>{
        'name': event.name,
        'lat': event.lat,
        'lng': event.lng,
        'address': event.address,
      });
    }
  }
}
