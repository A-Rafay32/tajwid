import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/auth/provider/auth_provider.dart';
import 'package:tajwid/features/auth/screens/register_screen.dart';
import 'package:tajwid/features/auth/screens/widgets/app_bar_white.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/auth/screens/widgets/forgot.dart';
import 'package:tajwid/features/auth/screens/widgets/form_field.dart';
import 'package:tajwid/features/auth/screens/widgets/header.dart';
import 'package:tajwid/features/auth/screens/widgets/signup_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
                usernameController: usernameController,
                passwordController: passwordController,
              ),
              AppSizes.tinyY,
              const Forgot(),
              AppSizes.largeY,
              Button(
                isLoading: authProvider.loading.isLoading,
                press: () {
                  context.read<AuthProvider>().login(
                    username: usernameController.text.trim(),
                    password: passwordController.text.trim(),
                    context: context,
                  );
                },
                text: "Login",
              ),
              AppSizes.normalY,
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
