import 'package:flutter/material.dart';

class AppLanguages {
  static get assetPath => 'assets/translations';

  static Locale get en => const Locale('en', 'US');
  static Locale get vi => const Locale('vi', 'VN');

  static get supportedLanguages => [
        en,
        vi,
      ];
}
