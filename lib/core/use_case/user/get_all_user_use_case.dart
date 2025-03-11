import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';
import 'package:flutter_base_bloc/domain/repository/user_repository.dart';
import 'package:flutter_base_bloc/core/use_case/base/base_use_case.dart';

class GetAllUserUseCase implements BaseUseCase<void, Result<List<UserModel>>> {
  final _repo = getIt.get<UserRepository>();
  @override
  Future<Result<List<UserModel>>> call(param) async {
    return await _repo.getAllUser();
  }
}
