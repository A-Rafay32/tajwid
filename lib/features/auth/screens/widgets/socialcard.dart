import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/core/extensions/text_theme_ext.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({super.key});

  static const List<String> assets = [
    "assets/svgs/google.svg",
    "assets/svgs/fb.svg",
    "assets/svgs/twitter.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            assets.length,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryColor),
              ),
              padding: const EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(assets[index], height: 30, width: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleSignInCard extends StatelessWidget {
  const GoogleSignInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AuthRepository().signInWithGoogle();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSizes.tinyX,
            SvgPicture.asset("assets/svgs/google.svg", height: 25, width: 25),
            AppSizes.tinyX,
            Text(
              "Sign in with Google",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
