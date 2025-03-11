import 'package:flutter_base_bloc/utils/constants/regex_constants.dart';

class Validator {
  static bool emptyValidate(String? value) {
    return (value?.isNotEmpty ?? false);
  }

  static String? passwordValidate(String? value, [String? returnMessage]) {
    final message = returnMessage ?? 'Invalid password';
    if (!emptyValidate(value)) {
      return message;
    }
    return RegexConstants.isPassword(value!) ? null : message;
  }

  static String? emailValidate(String? value, [String? returnMessage]) {
    final message = returnMessage ?? 'Invalid email';
    if (!emptyValidate(value)) {
      return message;
    }
    return RegexConstants.isEmail(value!) ? null : message;
  }
}
