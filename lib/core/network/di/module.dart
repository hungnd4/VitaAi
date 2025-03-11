import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/data/repository_impl/repo_impl.dart';
import 'package:flutter_base_bloc/data/services/services.dart';
import 'package:flutter_base_bloc/domain/repository/repository.dart';
import 'package:get_it/get_it.dart';

import '../../base/common/common_bloc.dart';

import '../../use_case/use_case.dart';
import '../../../utils/constants/app_constants.dart';
import 'middle_ware/middle_ware.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton(GlobalKey<NavigatorState>());

  void blocDI(GetIt di) {
    di.registerSingleton<CommonBloc>(CommonBloc());
  }

  void serviceDI(GetIt di) {
    di.registerSingleton<LoginService>(LoginService(provideDio()));
    di.registerSingleton<UserService>(UserService(provideDio()));
  }

  void repositoryDI(GetIt di) {
    di.registerSingleton<LoginRepository>(LoginRepoImpl(getIt.get()));
    di.registerSingleton<UserRepository>(UserRepoImpl(getIt.get()));
  }

  void usecaseDI(GetIt di) {
    di.registerSingleton<LoginUseCase>(LoginUseCase());
    di.registerSingleton<GetAllUserUseCase>(GetAllUserUseCase());
    di.registerSingleton<GetUserUseCase>(GetUserUseCase());
    di.registerSingleton(RegistrationUseCase());
    di.registerSingleton(GetUserInfoUseCase());
  }

  blocDI(getIt);
  serviceDI(getIt);
  repositoryDI(getIt);
  usecaseDI(getIt);
}

Dio provideDio({String? baseURL}) {
  final options = BaseOptions(
    baseUrl: baseURL ?? AppConstants.baseUrl,
    receiveTimeout: AppConstants.receiveTimeout,
    connectTimeout: AppConstants.connectTimeout,
    followRedirects: false,
  );
  final dio = Dio(options);

  dio.transformer = BackgroundTransformer();
  dio.interceptors.addAll([
    ConnectivityInterceptor(),
    HeaderInterceptors(),
    AuthInterceptor(),
    RefreshTokenInterceptors(dio),
    if (foundation.kDebugMode) CustomLogger()
  ]);

  return dio;
}
