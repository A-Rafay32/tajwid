import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/app_paddings.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColors = AppColors.textBlackColor,
    this.enableBackButton = true,
    this.actions,
    this.bottom,
    required this.onPressed,
    required this.text,
  });

  final String text;
  bool enableBackButton;
  final Function() onPressed;
  final Color backgroundColor;
  final Color textColors;
  List<Widget>? actions;
  PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(text, style: TextStyle(color: textColors, fontSize: 21.sp)),
      actions: actions,
      bottom: bottom,
      leading:
          enableBackButton
              ? CupertinoNavigationBarBackButton(
                color: textColors,
                onPressed: onPressed,
              )
              : null,
    );
  }
}
