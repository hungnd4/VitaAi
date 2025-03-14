import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/presentation/widgets/textField/text_field_common.dart';

class ItemBoxForm extends StatelessWidget {
  final TextEditingController controllerItem;
  final String hintTextItem;
  const ItemBoxForm({
    super.key,
    required this.hintTextItem,
    required this.controllerItem,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.d4),
        child: TextFieldCommon(
          maxLength: 1,
          textAlign: TextAlign.center,
          hintText: hintTextItem,
          controller: controllerItem,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
