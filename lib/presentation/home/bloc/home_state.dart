part of 'home_bloc.dart';

@freezed
class HomeState extends BaseState with _$HomeState {
  const factory HomeState({
    @Default(<UserModel>[]) List<UserModel> users,
    UserModel? userInfo,
    @Default(PageType.home) PageType currentPageType,
    AppException? err,
  }) = _HomeState;
}
