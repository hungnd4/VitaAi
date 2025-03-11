part of 'home_bloc.dart';

@freezed
class HomeEvent extends BaseEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.getAllUser() = _OnGetAllUser;
  const factory HomeEvent.getUser(String id) = _OnGetUser;
  const factory HomeEvent.changePage(int page) = _OnChangedPage;
  const factory HomeEvent.getUserInfo() = _OnGetUserInfo;
}
