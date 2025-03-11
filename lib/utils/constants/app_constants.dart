// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String appName = dotenv.get('APP_NAME', fallback: '');
  static String baseUrl = dotenv.get('BASE_URL', fallback: '');
  static Duration receiveTimeout = const Duration(seconds: 30);
  static Duration connectTimeout = const Duration(seconds: 30);
}

enum AppMode { LIGHT, DARK }

enum ServerType { DEV, QA, STAGING, PRODUCT }
