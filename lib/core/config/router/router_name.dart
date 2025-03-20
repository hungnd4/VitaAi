class RoutesName {
  static RoutesGen get login => const RoutesGen('login');
  static RoutesGen get register => const RoutesGen('register');
  static RoutesGen get main => const RoutesGen('main', '');
  static RoutesGen get screenOne => const RoutesGen('screenOne');
  static RoutesGen get cameraScreen => const RoutesGen('cameraScreen');
  static RoutesGen get imageScreen => const RoutesGen('imageScreen');
}

class RoutesGen {
  final String value;
  final String? pathValue;
  const RoutesGen(this.value, [this.pathValue]);

  String get name => value;
  String get path => '/${pathValue ?? value}';
}
