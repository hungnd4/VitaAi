import 'package:flutter_base_bloc/gen/assets.gen.dart';

enum PageType {
  home(0),
  chatBot(1),
  news(2),
  setting(3);

  final int pageIndex;
  const PageType(this.pageIndex);

  static getPageFromIndex(int index) {
    try {
      return PageType.values.firstWhere(
        (element) => element.pageIndex == index,
      );
    } catch (_) {
      return PageType.home;
    }
  }
}

extension PageTypeExtension on PageType {
  SvgGenImage get svgGenImage {
    switch (this) {
      case PageType.home:
        return Assets.icons.icHome;
      case PageType.chatBot:
        return Assets.icons.icChatbot;
      case PageType.news:
        return Assets.icons.icNews;
      case PageType.setting:
        return Assets.icons.icSetting;
    }
  }
}
