part of 'common_bloc.dart';

@freezed
class CommonState extends BaseState with _$CommonState {
  const factory CommonState({
    ExceptionWrapper? wrapper,
    @Default(false) bool isLoading,
  }) = _CommonState;
}
