part of 'screen_one_bloc.dart';

enum FetchStatus {
  init,
  loading,
  success,
}

@freezed
class ScreenOneState extends BaseState with _$ScreenOneState {
  const factory ScreenOneState({
    @Default(FetchStatus.init) FetchStatus dataStatus,
  }) = _ScreenOneState;
}
