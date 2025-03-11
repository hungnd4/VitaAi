part of 'screen_one_bloc.dart';

@freezed
class ScreenOneEvent extends BaseEvent with _$ScreenOneEvent {
  const factory ScreenOneEvent.onStarted() = _OnStarted;
  const factory ScreenOneEvent.onLoadApi() = _OnLoadApi;
}
