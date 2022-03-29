import 'package:flutter/cupertino.dart';
import 'package:grock/grock.dart';

class TextInput extends StatelessWidget {
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? placeHolder;
  bool? obsText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  TextInput({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.placeHolder,
    this.obsText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      padding: [10, 13].horizontalAndVerticalP,
      suffix: Padding(
        padding: suffixIcon == null ? 0.allP : 7.onlyRightP,
        child: suffixIcon,
      ),
      prefix: Padding(
        padding: prefixIcon == null ? 0.allP : 7.onlyLeftP,
        child: prefixIcon,
      ),
      placeholder: placeHolder,
      obscureText: obsText ?? false,
      keyboardType: keyboardType,
    );
  }
}
