import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/domain/locals/prefs_service.dart';
import 'package:flutter_base_bloc/utils/common.dart';
import 'package:flutter_base_bloc/utils/constants/api_constants.dart';
import 'base_interceptors.dart';

class RefreshTokenInterceptors extends BaseInterceptors {
  final Dio _dio;
  RefreshTokenInterceptors(this._dio);
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final options = err.response!.requestOptions;
      _onExpiredToken(options, handler);
    } else {
      handler.next(err);
    }
  }

  void _onExpiredToken(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) async {
    final token = await _refreshToken();
    if (token.isEmpty) {
      exitApp();
      return handler.reject(
        DioException.badCertificate(requestOptions: options),
      );
    }
    PrefsService.saveToken(token);
    final res =
        await _dio.fetch(options..headers['Authorization'] = 'Bearer $token');
    return handler.resolve(res);
  }

  Future<String> _refreshToken() async {
    try {
      final response =
          await provideDio().post('${ApiConstants.AUTH}refreshToken', data: {
        'refreshToken': PrefsService.getRefreshToken(),
      });
      return response.data['data'] ?? '';
    } catch (e) {
      return '';
    }
  }
}
