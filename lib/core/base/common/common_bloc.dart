import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exception/exception_wrapper.dart';
import '../bloc/base_bloc.dart';

part 'common_event.dart';
part 'common_state.dart';

part 'common_bloc.freezed.dart';

class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState()) {
    on<LoadingVisibilityEmitted>(
      _onLoadingVisibilityEmitted,
    );

    on<ExceptionEmitted>(
      _onExceptionEmitted,
    );
  }

  FutureOr<void> _onLoadingVisibilityEmitted(
    LoadingVisibilityEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  FutureOr<void> _onExceptionEmitted(
    ExceptionEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(state.copyWith(wrapper: event.wrapper));
  }
}
