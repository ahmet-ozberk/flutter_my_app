import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void SuccessMessage({
  required String title,
  required String description,
}) {
  Grock.snackBar(
    title: title,
    description: description,
    titleColor: CupertinoColors.white,
    descriptionColor: CupertinoColors.white,
    borderRadius: 10,
    bgColor: CupertinoColors.activeGreen,
    opacity: 0.7,
    blur: 10,
    icon: CupertinoIcons.check_mark_circled_solid,
    iconColor: CupertinoColors.white,
  );
}

void ErrorMessage({
  required String title,
  required String description,
}) {
  Grock.snackBar(
    title: title,
    description: description,
    titleColor: CupertinoColors.white,
    descriptionColor: CupertinoColors.white,
    borderRadius: 10,
    bgColor: CupertinoColors.systemRed,
    opacity: 0.7,
    blur: 10,
    icon: Icons.error,
    iconColor: CupertinoColors.white,
  );
}
