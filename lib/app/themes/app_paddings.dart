import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPaddings {
  static final normal = EdgeInsets.all(22.h);
  static final normalX = EdgeInsets.symmetric(horizontal: 22.w);
  static final normalY = EdgeInsets.symmetric(vertical: 22.h);

  static final small = EdgeInsets.all(14.h);
  static final smallX = EdgeInsets.symmetric(horizontal: 14.w);
  static final smallY = EdgeInsets.symmetric(vertical: 14.h);

  static final tiny = EdgeInsets.all(6.h);
  static final tinyX = EdgeInsets.symmetric(horizontal: 6.w);
  static final tinyY = EdgeInsets.symmetric(vertical: 6.h);

  static custom(double val) => EdgeInsets.all(val);
  static customX(int w) => EdgeInsets.symmetric(horizontal: w.w);
  static customY(int h) => EdgeInsets.symmetric(vertical: h.h);
}

class AppSizes {
  static final tinyX = SizedBox(width: 6.w);
  static final tinyY = SizedBox(height: 6.h);

  static final smallX = SizedBox(width: 16.w);
  static final smallY = SizedBox(height: 16.h);

  static final normalX = SizedBox(width: 24.w);
  static final normalY = SizedBox(height: 24.h);

  static final largeX = SizedBox(width: 40.w);
  static final largeY = SizedBox(height: 40.h);

  static customX(int w) => SizedBox(width: w.w);
  static customY(int h) => SizedBox(height: h.h);
}
