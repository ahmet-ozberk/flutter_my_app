import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class Button extends StatelessWidget {
  String text;
  Function onPressed;
  Color? bgColor;
  Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text(
          text,
        ),
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          primary: bgColor ?? CupertinoColors.activeBlue,
          shape: RoundedRectangleBorder(
            borderRadius: 10.allBR,
          ),
        ),
      ),
    );
  }
}
