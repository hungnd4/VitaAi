import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/data/request/create_user_request.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';
import 'package:flutter_base_bloc/domain/repository/user_repository.dart';
import 'package:flutter_base_bloc/core/use_case/base/base_use_case.dart';

class RegistrationUseCase
    implements BaseUseCase<RegistrationRequest, Result<LoginModel>> {
  final _repo = getIt.get<UserRepository>();
  @override
  Future<Result<LoginModel>> call(param) async {
    return await _repo.register(param);
  }
}
