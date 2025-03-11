import 'dart:async';

import 'package:flutter_base_bloc/core/base/bloc/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_one_event.dart';
part 'screen_one_state.dart';

part 'screen_one_bloc.freezed.dart';

class ScreenOneBloc extends BaseBloc<ScreenOneEvent, ScreenOneState> {
  ScreenOneBloc() : super(const ScreenOneState()) {
    on<_OnLoadApi>(_onLoadApi);
  }

  FutureOr<void> _onLoadApi(
      _OnLoadApi event, Emitter<ScreenOneState> emit) async {
    emit(
      state.copyWith(dataStatus: FetchStatus.init),
    );
    await blocCatching<void>(
        action: Future.delayed(const Duration(seconds: 1)),
        onSuccess: (_) {
          emit(state.copyWith(dataStatus: FetchStatus.success));
        });
  }
}
