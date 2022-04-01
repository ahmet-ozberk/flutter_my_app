import 'package:flutter/cupertino.dart';
import 'package:grock/grock.dart';

class TextInput extends StatelessWidget {
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? placeHolder;
  bool? obsText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  int? maxLines;
  Function(String value)? onSubmitted;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  TextInput({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.placeHolder,
    this.obsText,
    this.controller,
    this.keyboardType,
    this.maxLines,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      focusNode: focusNode,
      controller: controller,
      padding: [10, 10].horizontalAndVerticalP,
      suffix: Padding(
        padding: suffixIcon == null ? 0.allP : 7.onlyRightP,
        child: suffixIcon,
      ),
      prefix: Padding(
        padding: prefixIcon == null ? 0.allP : 7.onlyLeftP,
        child: prefixIcon,
      ),
      onSubmitted: (value) => onSubmitted?.call(value),
      placeholder: placeHolder,
      obscureText: obsText ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
    );
  }
}
