import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final void Function()? onPressed;
  const DefaultButton(
      {super.key,
      required this.child,
      this.padding,
      this.margin,
      this.borderRadius,
      this.onPressed,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.amber,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
