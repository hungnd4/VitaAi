part of 'main_bloc.dart';

@freezed
class MainState extends BaseState with _$MainState {
  const factory MainState({
    @Default(<UserModel>[]) List<UserModel> users,
    UserModel? userInfo,
    @Default(PageType.home) PageType currentPageType,
    AppException? err,
  }) = _MainState;
}
