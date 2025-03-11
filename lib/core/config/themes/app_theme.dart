import '../../../utils/constants/app_constants.dart';
import '../app_config.dart';
import '../resources/color.dart';

class AppTheme {
  static AppColor? _instance;

  static AppColor getInstance() {
    _instance ??= AppMode.LIGHT == APP_THEME ? LightApp() : DarkApp();
    return _instance!;
  }
}
