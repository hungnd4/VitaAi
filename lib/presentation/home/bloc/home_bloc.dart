import 'dart:async';
import 'dart:developer';

import 'package:flutter_base_bloc/core/base/bloc/base_bloc.dart';
import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/core/exception/exception.dart';
import 'package:flutter_base_bloc/data/request/find_user_request.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';
import 'package:flutter_base_bloc/core/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final _getAllUserUsecase = getIt.get<GetAllUserUseCase>();
  final _getUserUsecase = getIt.get<GetUserUseCase>();
  final _getUserInfoUsecase = getIt.get<GetUserInfoUseCase>();

  HomeBloc() : super(const HomeState()) {
    on<_OnGetAllUser>(_onGetAllUser);
    on<_OnChangedPage>(_onChangedPage);
    on<_OnGetUser>(_onGetUser);
    on<_OnGetUserInfo>(_onUserInfo);
  }

  FutureOr<void> _onGetAllUser(
      _OnGetAllUser event, Emitter<HomeState> emit) async {
    await blocResultCatching<List<UserModel>>(
      action: _getAllUserUsecase(()),
      onSuccess: (data) {
        emit(
          state.copyWith(
            users: data,
            err: null,
          ),
        );
      },
      doOnError: (err) {
        emit(
          state.copyWith(
            users: [],
            err: err,
          ),
        );
      },
    );
  }

  FutureOr<void> _onGetUser(_OnGetUser event, Emitter<HomeState> emit) async {
    await blocResultCatching<UserModel>(
      action: _getUserUsecase(FindUserRequest(keyword: event.id)),
      onSuccess: (data) {
        log(data.toString());
      },
      doOnError: (err) {},
    );
  }

  FutureOr<void> _onUserInfo(
      _OnGetUserInfo event, Emitter<HomeState> emit) async {
    await blocResultCatching<UserModel>(
      action: _getUserInfoUsecase(()),
      onSuccess: (data) {
        emit(state.copyWith(userInfo: data));
      },
      doOnError: (err) {},
    );
  }

  FutureOr<void> _onChangedPage(
      _OnChangedPage event, Emitter<HomeState> emit) async {
    if (state.currentPageIndex != event.page) {
      emit(
        state.copyWith(currentPageIndex: event.page),
      );
    }
  }
}
