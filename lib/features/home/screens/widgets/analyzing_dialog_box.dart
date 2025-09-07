import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';

class AnalyzingDialog extends StatefulWidget {
  const AnalyzingDialog({
    super.key,
    required this.w,
    required this.image,
    required this.title,
    required this.message,
    required this.onTap,
  });

  final double w;
  final String image;
  final String title;
  final String message;
  final Function() onTap;

  @override
  State<AnalyzingDialog> createState() => _AnalyzingDialogState();
}

class _AnalyzingDialogState extends State<AnalyzingDialog>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _opacityController;

  @override
  void initState() {
    super.initState();

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Scale pulsing animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Opacity twinkling animation
    _opacityController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: context.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(42)),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Analyzing",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              AppSizes.tinyX,
              Column(
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(3, (index) {
                      return AnimatedBuilder(
                        animation: _opacityController,
                        builder: (context, child) {
                          double delay = index * 0.3;
                          double animValue =
                              (_opacityController.value + delay) % 1.0;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(
                                0.3 + (animValue * 0.7),
                              ),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "Processing your tajwid, thank you for your patience!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 60.h),
          AnimatedBuilder(
            animation: Listenable.merge([
              _rotationController,
              _scaleController,
              _opacityController,
            ]),
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * 3.14159,
                child: Transform.scale(
                  scale: 0.8 + (_scaleController.value * 0.4),
                  child: Opacity(
                    opacity: 0.6 + (_opacityController.value * 0.4),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: CustomPaint(painter: StarPainter()),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class StarLoadingContainer extends StatefulWidget {
  final String title;
  final String message;
  final bool isLoading;

  const StarLoadingContainer({
    super.key,
    required this.title,
    required this.message,
    this.isLoading = true,
  });

  @override
  State<StarLoadingContainer> createState() => _StarLoadingContainerState();
}

class _StarLoadingContainerState extends State<StarLoadingContainer>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _opacityController;

  @override
  void initState() {
    super.initState();

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Scale pulsing animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Opacity twinkling animation
    _opacityController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 340.w,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.2),
        // borderRadius: BorderRadius.circular(42),
        // border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.white.withOpacity(0.25),
        //     blurRadius: 20,
        //     offset: const Offset(0, 8),
        //   ),
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),
        //     blurRadius: 10,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLoading) ...[
            // Star Loading Animation
            AnimatedBuilder(
              animation: Listenable.merge([
                _rotationController,
                _scaleController,
                _opacityController,
              ]),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2 * 3.14159,
                  child: Transform.scale(
                    scale: 0.8 + (_scaleController.value * 0.4),
                    child: Opacity(
                      opacity: 0.6 + (_opacityController.value * 0.4),
                      child: CustomPaint(painter: StarPainter()),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            // // Thinking dots animation
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(3, (index) {
            //     return AnimatedBuilder(
            //       animation: _opacityController,
            //       builder: (context, child) {
            //         double delay = index * 0.3;
            //         double animValue = (_opacityController.value + delay) % 1.0;
            //         return Container(
            //           margin: const EdgeInsets.symmetric(horizontal: 2),
            //           width: 8,
            //           height: 8,
            //           decoration: BoxDecoration(
            //             color: AppColors.primaryColor.withOpacity(
            //               0.3 + (animValue * 0.7),
            //             ),
            //             shape: BoxShape.circle,
            //           ),
            //         );
            //       },
            //     );
            //   }),
            // ),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.4;
    final innerRadius = outerRadius * 0.4;

    final path = Path();

    // Create a 6-pointed star
    // for (int i = 0; i < 6; i++) {
    // double angle = (i * 60) * (3.14159 / 180);
    // double nextAngle = ((i + 1) * 60) * (3.14159 / 180);

    // // Outer point
    // double outerX = center.dx + outerRadius * cos(angle);
    // double outerY = center.dy + outerRadius * sin(angle);

    // // Inner point (between outer points)
    // double innerAngle = angle + (30 * 3.14159 / 180);
    // double innerX = center.dx + innerRadius * cos(innerAngle);
    // double innerY = center.dy + innerRadius * sin(innerAngle);

    // if (i == 0) {
    //   path.moveTo(outerX, outerY);
    // } else {
    //   path.lineTo(outerX, outerY);
    // }

    // path.lineTo(innerX, innerY);
    // }

    path.close();
    canvas.drawPath(path, paint);

    // Add a glowing effect
    paint.color = Colors.white.withOpacity(0.3);
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
