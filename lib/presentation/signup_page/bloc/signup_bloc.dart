import 'dart:async';
import 'dart:math';

import 'package:flutter_base_bloc/core/base/bloc/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

class SignupBloc extends BaseBloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<_OnStartCountdown>(_onStartCountdown);
  }
  Future<void> _onStartCountdown(
      _OnStartCountdown event, Emitter<SignupState> emit) async {
    emit(
      state.copyWith(remainTime: 10),
    );

    while (state.remainTime > 0) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        remainTime: state.remainTime - 1,
        isFirstTime: false,
      ));
    }
  }
}
