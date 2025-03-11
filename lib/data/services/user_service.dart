import 'package:dio/dio.dart';
import 'package:flutter_base_bloc/data/request/create_user_request.dart';
import 'package:flutter_base_bloc/data/request/find_user_request.dart';
import 'package:flutter_base_bloc/data/response/response_wrapper.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';
import 'package:flutter_base_bloc/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  @factoryMethod
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET(ApiConstants.USER + ApiConstants.GET_ALL_USER)
  Future<ResponseWrapper<List<UserModel>>> getAllUsers();

  @POST(ApiConstants.USER + ApiConstants.FIND_USER_INFO)
  Future<ResponseWrapper<UserModel>> getUser(
    @Body() FindUserRequest keyword,
  );

  @POST(ApiConstants.AUTH + ApiConstants.REGISTER)
  Future<ResponseWrapper<LoginModel>> register(
      @Body() RegistrationRequest request);

  @GET(ApiConstants.AUTH + ApiConstants.GET_INFO)
  Future<ResponseWrapper<UserModel>> getInfo();
}
