import 'package:flutter_base_bloc/core/base/bloc/base_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

class SignupBloc extends BaseBloc<SignupEvent, SignupState> {
  SignupBloc() : super(_Initial()) {
    on<SignupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
