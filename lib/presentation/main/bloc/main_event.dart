part of 'main_bloc.dart';

@freezed
class MainEvent extends BaseEvent with _$MainEvent {
  const factory MainEvent.started() = _Started;
  const factory MainEvent.getAllUser() = _OnGetAllUser;
  const factory MainEvent.getUser(String id) = _OnGetUser;
  const factory MainEvent.changePage(PageType page) = _OnChangedPage;
  const factory MainEvent.getUserInfo() = _OnGetUserInfo;
}
