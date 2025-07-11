import 'package:deenly/core/ui/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';

extension StringAsWidgetExtensions on String {
  DefaultButton asDefaultButton(
      {Color? backgroundColor, void Function()? onPressed}) {
    return DefaultButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: Text(this),
    );
  }
}
