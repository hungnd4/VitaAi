part of 'signup_bloc.dart';

@freezed
class SignupState extends BaseState with _$SignupState {
  const factory SignupState({
    @Default(true) bool isFirstTime,
    @Default(0) int remainTime,
  }) = _SignupState;
}
