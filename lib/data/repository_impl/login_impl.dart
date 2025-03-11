import 'package:flutter_base_bloc/data/request/login_request.dart';
import 'package:flutter_base_bloc/data/response/response_wrapper.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/data/services/login_service.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';
import 'package:flutter_base_bloc/domain/repository/login_repository.dart';

class LoginRepoImpl implements LoginRepository {
  final LoginService _service;

  LoginRepoImpl(this._service);

  @override
  Future<Result<LoginModel>> login(LoginRequest request) {
    return runCatchingAsync<ResponseWrapper<LoginModel>, LoginModel>(
      () => _service.login(request),
      (res) => res.data,
    );
  }
}
