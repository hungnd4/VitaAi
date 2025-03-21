part of 'signup_bloc.dart';

@freezed
class SignupEvent extends BaseEvent with _$SignupEvent {
  const factory SignupEvent.started() = _Started;
  const factory SignupEvent.startCountdown() = _OnStartCountdown;
  const factory SignupEvent.handleFocusChanged() = _OnHandleFocusChanged;
}
