import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/app/themes/app_text_field_themes.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/auth/screens/widgets/app_bar_white.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/auth/screens/widgets/custom_text_field.dart';
import 'package:tajwid/features/auth/screens/widgets/header.dart';
import 'package:tajwid/features/auth/screens/widgets/signup_bar.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController tokenController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    tokenController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    tokenController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: CustomAppBar(
          onPressed: () {
            context.pop();
          },
          text: "Set New Password",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: AppPaddings.normal,
          height: context.h,
          width: context.w,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                LoginHeader(w: context.w, text1: "Reset Your Password!"),
                AppSizes.largeY,
                AppSizes.largeY,
                // CustomTextField(
                //   validator: (value) {
                //     return tokenController.text.isEmpty
                //         ? "Reset Token can't be empty"
                //         : null;
                //   },
                //   controller: tokenController,
                //   inputDecoration:
                //       AppTextFieldDecorations.genericInputDecoration(
                //         label: "Reset Token",
                //         hint: "Enter your reset token",
                //       ),
                // ),
                // AppSizes.normalY,

                // CustomTextField(
                //   validator: (value) {
                //     return emailController.text.isEmpty
                //         ? "email can't be empty"
                //         : null;
                //   },
                //   controller: emailController,
                //   inputDecoration:
                //       AppTextFieldDecorations.genericInputDecoration(
                //         label: "Email",
                //         hint: "Enter your email",
                //       ),
                // ),
                // AppSizes.normalY,
                CustomTextField(
                  validator: (value) {
                    return passwordController.text.isEmpty
                        ? "password can't be empty"
                        : null;
                  },
                  controller: passwordController,
                  inputDecoration:
                      AppTextFieldDecorations.genericInputDecoration(
                        label: "New Password ",
                        hint: "Enter your new password",
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                ),
                AppSizes.normalY,
                CustomTextField(
                  validator: (value) {
                    return confirmPasswordController.text.isEmpty
                        ? "confirm password can't be empty"
                        : null;
                  },
                  controller: confirmPasswordController,
                  inputDecoration:
                      AppTextFieldDecorations.genericInputDecoration(
                        label: "Confirm Password ",
                        hint: "Confirm your new password",
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                ),
                AppSizes.largeY,
                Button(
                  // isLoading: authProvider.loading.isLoading,
                  press: () {
                    //   if (formKey.currentState?.validate() ?? false) {
                    //     context.read<AuthProvider>().setNewPassword(
                    //       passwordController.text.trim(),
                    //       context,
                    //     );
                    //   }
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
      ),
    );
  }
}
