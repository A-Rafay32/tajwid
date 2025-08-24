import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/app/themes/app_text_field_themes.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/auth/screens/update_password_screen.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/auth/screens/widgets/custom_text_field.dart';

class CheckEmailDialog extends StatelessWidget {
  const CheckEmailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: context.w * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Check Your Email",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 21.sp,
                color: Colors.black87,
              ),
            ),
            AppSizes.smallY,
            Text(
              "We've sent a reset token to your email, Please check your inbox and use the token to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
            AppSizes.normalY,
            Button(
              press: () {
                context.pop();
                context.pop();
                // context.pushReplacement(SetNewPasswordScreen());
              },
              text: "Close",
            ),
          ],
        ),
      ),
    );
  }
}
