// ignore_for_file: depend_on_referenced_packages, constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../exception/remote_exception.dart';

class CheckerNetwork {
  static const String GOOGLE_URL = 'https://www.google.com/';
  static const int STATUS_CODE_SUCCESS = 200;

  static Future<bool> checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }

  static Future<bool> checkNetworkByGoogle() async {
    try {
      final http.Response response = await http
          .get(Uri.parse(GOOGLE_URL))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == STATUS_CODE_SUCCESS) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (error) {
      throw RemoteException(
        kind: RemoteExceptionKind.connectionTimeout,
        overrideMessage: error.message,
      );
    } on SocketException {
      throw RemoteException(
        kind: RemoteExceptionKind.noInternet,
        overrideMessage: 'S.current.net_work',
      );
    }
  }
}
