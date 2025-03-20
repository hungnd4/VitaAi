import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/utils/constants/regex_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ItemBoxForm extends StatefulWidget {
  final TextEditingController controllerItem;
  final String? hintTextItem;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final FocusNode? previousFocus;

  const ItemBoxForm({
    super.key,
    required this.controllerItem,
    required this.hintTextItem,
    required this.currentFocus,
    this.nextFocus,
    this.previousFocus,
  });

  @override
  _ItemBoxFormState createState() => _ItemBoxFormState();
}

class _ItemBoxFormState extends State<ItemBoxForm> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.currentFocus.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.currentFocus.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = widget.currentFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.d50.h,
      width: Dimens.d50.w,
      child: TextFormField(
        controller: widget.controllerItem,
        focusNode: widget.currentFocus,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.nextFocus?.requestFocus();
          } else {
            widget.previousFocus?.requestFocus();
          }
        },
        decoration: InputDecoration(
          counterText: '',
          hintText: _isFocused ? '' : widget.hintTextItem,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: colorBlue, width: 1),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: colorFail, width: 1),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: colorFail, width: 1),
          ),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
            errorText: LocaleKeys.error.tr(),
          ),
          FormBuilderValidators.match(
            RegExp(RegexConstants.ONLY_DIGITS),
            errorText: LocaleKeys.error.tr(),
          ),
        ]),
      ),
    );
  }
}
