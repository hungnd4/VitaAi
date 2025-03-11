part of 'home_bloc.dart';

@freezed
class HomeState extends BaseState with _$HomeState {
  const factory HomeState({
    @Default(<UserModel>[]) List<UserModel> users,
    UserModel? userInfo,
    @Default(0) int currentPageIndex,
    AppException? err,
  }) = _HomeState;
}
