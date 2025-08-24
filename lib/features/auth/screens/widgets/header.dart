import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  LoginHeader({required this.w, required this.text1, super.key});

  final double w;
  String text1;

  @override
  Widget build(BuildContext context) {
    return Text(
      text1,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
