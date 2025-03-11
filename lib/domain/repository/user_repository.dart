import 'package:flutter_base_bloc/data/request/create_user_request.dart';
import 'package:flutter_base_bloc/data/request/find_user_request.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';

abstract class UserRepository {
  Future<Result<List<UserModel>>> getAllUser();
  Future<Result<UserModel>> getUser(FindUserRequest req);
  Future<Result<LoginModel>> register(RegistrationRequest request);
  Future<Result<UserModel>> getInfo();
}
