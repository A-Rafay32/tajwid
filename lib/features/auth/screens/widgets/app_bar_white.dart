import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/features/auth/provider/auth_provider.dart';

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

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
    this.enableBackButton = true,
    required this.onPressed,
    required this.text,
  });

  final String text;
  bool enableBackButton;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSizes.smallX,
          CircleAvatar(radius: 22),
          AppSizes.smallX,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade800),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              context.read<AuthProvider>().logOut();
            },
            child: SvgPicture.asset(
              "assets/svgs/logout.svg",
              height: 25.h,
              width: 25.w,
            ),
          ),
          AppSizes.smallX,
        ],
      ),
    );
  }
}
