import 'package:flutter_base_bloc/data/request/login_request.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';

abstract class LoginRepository {
  Future<Result<LoginModel>> login(LoginRequest request);
}
