import 'package:dio/dio.dart';
import 'package:flutter_base_bloc/utils/common.dart';

import 'exception.dart';

class ExceptionHandler {
  // void _showErrorDialog(ExceptionWrapper exceptionWrapper) {
  //   Get.dialog(
  //     ErrorAlertDialog(
  //       content: exceptionWrapper.exception.message,
  //     ),
  //     barrierColor: AppTheme.getInstance().barrierColor,
  //   );
  // }

  // void _showErrorRetryDialog(ExceptionWrapper exceptionWrapper) {
  //   Get.dialog(
  //     CustomAlertDialog(
  //       title: 'S.current.error',
  //       content: exceptionWrapper.exception.message,
  //       confirmText: 'S.current.retry',
  //       cancelText: 'S.current.cancel',
  //       onConfirm: () {
  //         Get.back();
  //         exceptionWrapper.doOnRetry?.call();
  //       },
  //     ),
  //     barrierColor: AppTheme.getInstance().barrierColor,
  //   );
  // }

  void handleException(ExceptionWrapper exceptionWrapper) {
    if (exceptionWrapper.doOnRetry != null) {
      //_showErrorRetryDialog(exceptionWrapper);
      return;
    }
    showToast(exceptionWrapper.exception.message);
    switch (exceptionWrapper.exception.type) {
      case AppExceptionType.remote:
        final exception = exceptionWrapper.exception as RemoteException;
        switch (exception.kind) {
          case RemoteExceptionKind.noInternet:
            break;
          case RemoteExceptionKind.connectionTimeout:
            break;
          case RemoteExceptionKind.connectionError:
            break;
          default:
            break;
        }
        break;
      default:
        //_showErrorDialog(exceptionWrapper);
        break;
    }
  }

  static AppException catchingRemoteExeption(Object excetion) {
    if (excetion is DioException) {
      return excetion.mapToAppExcetion();
    }
    return const UnCatchException();
  }
}

extension ExceptionMapper on DioException {
  AppException mapToAppExcetion() {
    if (response == null) {
      return RemoteException(
        kind: type.toRemoteKind,
        overrideMessage: message,
      );
    } else {
      if (response!.data is Map<String, dynamic>) {
        final json = response!.data as Map<String, dynamic>;
        json.addAll({'kind': type.toRemoteKind});
        return RemoteException.fromJson(json);
      } else {
        return RemoteException(
          httpCode: response!.statusCode ?? 0,
          kind: type.toRemoteKind,
          overrideMessage: response!.statusMessage,
        );
      }
    }
  }
}
