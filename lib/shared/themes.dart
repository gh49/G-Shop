import 'package:flutter/material.dart';

TextStyle SmallText(BuildContext context, {Color? color}) {
  color ??= Theme.of(context).textTheme.bodyMedium!.color;

  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontFamily: "QuickSand",
    color: color
  );
}