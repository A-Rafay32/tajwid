import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/app/themes/app_text_field_themes.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/auth/screens/update_password_screen.dart';
import 'package:tajwid/features/auth/screens/widgets/app_bar_white.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/auth/screens/widgets/custom_text_field.dart';
import 'package:tajwid/features/auth/screens/widgets/header.dart';
import 'package:tajwid/features/auth/screens/widgets/signup_bar.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: CustomAppBar(onPressed: () => context.pop(), text: ""),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: AppPaddings.normal,
          child: Column(
            children: [
              LoginHeader(
                w: context.w,
                text1:
                    "Recover Password, Provide either your email or phone Number",
              ),
              AppSizes.largeY,
              AppSizes.largeY,
              CustomTextField(
                validator: (value) {
                  return value == null ? "Field can't be empty" : null;
                },
                controller: emailController,
                inputDecoration: AppTextFieldDecorations.emailInputDecoration,
              ),
              AppSizes.largeY,
              Button(
                // isLoading: context.watch<AuthProvider>().loading.isLoading,
                press: () {
                  // context.read<AuthProvider>().resetPassword(
                  //   emailController.text.trim(),
                  //   context,
                  // );
                },
                text: "Submit",
              ),
              const Spacer(),
              SignUpBar(
                onTap: () => context.pop(),
                text1: "Already rememeber password?",
                text2: "Sign in",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
