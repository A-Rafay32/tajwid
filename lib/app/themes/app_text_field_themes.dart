import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/text_theme.dart';

class AppTextFieldDecorations {
  static InputDecoration searchFieldDecoration(
    BuildContext context,
  ) => InputDecoration(
    fillColor: AppColors.textFieldColor,
    filled: true,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.textFieldColor),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
    // suffixIcon: Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
    //   child: const CircleAvatar(
    //     backgroundColor: Colors.green,
    //     backgroundImage: AssetImage("assets/svgs/profile/user_avatar.png"),
    //     radius: 3,
    //   ),
    // ),
    // prefixIcon: IconButton(
    //   onPressed: () {
    //     // Scaffold.of(context).openDrawer();
    //     // _scaffoldKey.currentState!.openDrawer();
    //   },
    //   icon: Icon(Icons.menu, size: 10.sp, color: Colors.black54),
    // ),
    contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 19.h),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: "Search",
    hintStyle: AppTextTheme.textTheme.bodyLarge?.copyWith(
      color: Colors.black54,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade900),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade900),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(25),
      gapPadding: 10,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(25),
      gapPadding: 10,
    ),
  );

  static final emailInputDecoration = InputDecoration(
    suffixIcon: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Icon(Icons.email_outlined, color: Colors.black54),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 23.h),
    labelText: "Email",
    labelStyle: const TextStyle(color: Colors.black87),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: "Enter your email",
    hintStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
      color: Colors.black54.withOpacity(0.4),
      fontWeight: FontWeight.w900,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade900),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade900),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black87),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black87),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10,
    ),
  );

  static passwordInputDecoration(bool isObscure, Function() onPressed) {
    return InputDecoration(
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: IconButton(
          onPressed: onPressed,
          icon:
              (isObscure)
                  ? SvgPicture.asset(
                    "assets/svgs/eye_closed.svg",
                    height: 30,
                    width: 30,
                    colorFilter: const ColorFilter.mode(
                      Colors.black87,
                      BlendMode.srcIn,
                    ),
                  )
                  : SvgPicture.asset(
                    "assets/svg/eye_open.svg",
                    height: 30,
                    width: 30,
                    colorFilter: const ColorFilter.mode(
                      Colors.black87,
                      BlendMode.srcIn,
                    ),
                  ),
          iconSize: 28,
          color: Colors.black87,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 23.h),
      labelText: "Password",
      labelStyle: const TextStyle(color: Colors.black87),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: "Enter your password",
      hintStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
        color: Colors.black54.withOpacity(0.4),
        fontWeight: FontWeight.w900,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
    );
  }

  static genericInputDecoration({
    Widget? suffixIcon,
    String? hint,
    required String label,
  }) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 23.h),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: hint ?? "Enter your ${label.toLowerCase()}",
      hintStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
        color: Colors.black54.withOpacity(0.6),
        fontWeight: FontWeight.w900,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
    );
  }

  static genericInputDecoration2({
    Widget? suffixIcon,
    String? hint,
    required String label,
  }) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 23.h),
      // labelText: label,
      // labelStyle: const TextStyle(color: Colors.black87),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: hint ?? "Enter your ${label.toLowerCase()}",
      hintStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
        color: Colors.black54.withOpacity(0.6),
        fontWeight: FontWeight.w900,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
    );
  }

  static genericInputDecoration3({Widget? suffixIcon, String? hint}) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 23.h),
      // labelText: label,
      // labelStyle: const TextStyle(color: Colors.black87),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: hint ?? "",
      hintStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
        color: Colors.black54.withOpacity(0.6),
        fontWeight: FontWeight.w900,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10,
      ),
    );
  }
}
