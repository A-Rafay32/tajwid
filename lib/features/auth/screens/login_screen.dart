import 'package:flutter/material.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/auth/screens/register_screen.dart';
import 'package:tajwid/features/auth/screens/widgets/app_bar_white.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/auth/screens/widgets/forgot.dart';
import 'package:tajwid/features/auth/screens/widgets/form_field.dart';
import 'package:tajwid/features/auth/screens/widgets/header.dart';
import 'package:tajwid/features/auth/screens/widgets/signup_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: CustomAppBar(
          onPressed: () => context.pop(),
          text: "",
          enableBackButton: false,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: context.h * 0.9,
          width: context.w,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              AppSizes.smallY,
              LoginHeader(
                w: context.w,
                text1: "Welcome Back, Glad to see you again!",
              ),
              AppSizes.largeY,
              AuthFormField(
                emailController: emailController,
                passwordController: passwordController,
              ),
              AppSizes.tinyY,
              const Forgot(),
              AppSizes.largeY,
              Button(
                // isLoading: authProvider.loading.isLoading,
                press: () {
                  // if (context
                  //         .read<AuthProvider>()
                  //         .formKey
                  //         .currentState
                  //         ?.validate() ??
                  //     false) {
                  //   context.read<AuthProvider>().login(
                  //     emailController.text.trim(),
                  //     passwordController.text.trim(),
                  //     context,
                  //   );
                  // }
                },
                text: "Login",
              ),
              AppSizes.normalY,

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 2,
              //       color: Colors.black26,
              //       width: context.w * 0.3,
              //     ),
              //     AppSizes.tinyX,
              //     Text("or sign in with", style: TextStyle(fontSize: 14.sp)),
              //     AppSizes.tinyX,
              //     Container(
              //       height: 2,
              //       color: Colors.black26,
              //       width: context.w * 0.3,
              //     ),
              //   ],
              // ),
              // AppSizes.normalY,
              // GoogleSignInCard(),
              Spacer(),
              SignUpBar(
                onTap: () => context.push(RegisterScreen()),
                text1: "Dont't have an account?  ",
                text2: "Sign up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
