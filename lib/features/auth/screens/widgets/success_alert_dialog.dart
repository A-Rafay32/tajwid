import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
  });

  final String title;
  final String message;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 340.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.h),
            Image.asset(
              "assets/home/success_msg.png",
              height: 180.h,
              width: 185.h,
            ),
            SizedBox(height: 30.h),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: AppColors.greenSuccessColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            Button(text: "OK", textColor: Colors.white, press: onTap),
          ],
        ),
      ),
    );
  }
}
