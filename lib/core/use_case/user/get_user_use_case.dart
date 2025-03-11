import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/data/request/find_user_request.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';
import 'package:flutter_base_bloc/domain/repository/user_repository.dart';
import 'package:flutter_base_bloc/core/use_case/base/base_use_case.dart';

class GetUserUseCase
    implements BaseUseCase<FindUserRequest, Result<UserModel>> {
  final _repo = getIt.get<UserRepository>();
  @override
  Future<Result<UserModel>> call(param) async {
    return await _repo.getUser(param);
  }
}
