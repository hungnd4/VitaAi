import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';

import '../../../core/config/themes/app_theme.dart';

class CommonButtonBack extends StatelessWidget {
  const CommonButtonBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Assets.icons.icBasicBack.svg(
          colorFilter: ColorFilter.mode(
            AppTheme.getInstance().formColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
