import 'package:dio/dio.dart';
import 'package:flutter_base_bloc/data/request/login_request.dart';
import 'package:flutter_base_bloc/data/response/response_wrapper.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';
import 'package:flutter_base_bloc/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'login_service.g.dart';

@RestApi()
abstract class LoginService {
  @factoryMethod
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST(ApiConstants.AUTH + ApiConstants.LOGIN)
  Future<ResponseWrapper<LoginModel>> login(@Body() LoginRequest request);
}
