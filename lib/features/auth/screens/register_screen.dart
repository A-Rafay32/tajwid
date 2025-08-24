import "package:email_validator/email_validator.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import "package:tajwid/app/themes/app_paddings.dart";
import "package:tajwid/app/themes/app_text_field_themes.dart";
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/auth/screens/widgets/app_bar_white.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/auth/screens/widgets/custom_text_field.dart';
import 'package:tajwid/features/auth/screens/widgets/header.dart';
import 'package:tajwid/features/auth/screens/widgets/logoWidget.dart';
import 'package:tajwid/features/auth/screens/widgets/signup_bar.dart';
import 'package:tajwid/features/auth/screens/widgets/socialcard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isReset = true;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isObscure = false;

  void setObscureText() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: CustomAppBar(
          onPressed: () => context.pop(),
          text: "",
          enableBackButton: true,
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
                text1: "Hello. Sign up with your email and password!",
              ),
              AppSizes.largeY,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (value) {
                        return value != null ? "Field can't be empty" : null;
                      },
                      controller: nameController,
                      inputDecoration:
                          AppTextFieldDecorations.genericInputDecoration(
                            label: "Name",
                          ),
                    ),
                    AppSizes.normalY,
                    CustomTextField(
                      validator: (value) {
                        return value != null && !EmailValidator.validate(value)
                            ? "Enter a valid email "
                            : null;
                      },
                      controller: emailController,
                      inputDecoration:
                          AppTextFieldDecorations.emailInputDecoration,
                    ),
                    AppSizes.normalY,

                    CustomTextField(
                      validator: (value) {
                        return value != null && value.length < 6
                            ? "Enter min 6 characters "
                            : null;
                      },
                      obscureText: isObscure,
                      controller: passwordController,
                      inputDecoration:
                          AppTextFieldDecorations.passwordInputDecoration(
                            isObscure,
                            setObscureText,
                          ),
                    ),
                  ],
                ),
              ),

              AppSizes.largeY,
              Button(
                // isLoading: authProvider.loading.isLoading,
                press: () {
                  // print("register hitted");
                  // context.read<AuthProvider>().register(
                  //   emailController.text.trim(),
                  //   passwordController.text.trim(),
                  //   nameController.text.trim(),
                  //   context,
                  // );
                },

                text: "Register",
              ),
              AppSizes.normalY,

              const Spacer(),
              SignUpBar(
                onTap: () => context.pop(),
                text1: "Already have an account?",
                text2: "Sign In",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotFormField extends StatefulWidget {
  const ForgotFormField({super.key});

  @override
  State<ForgotFormField> createState() => _ForgotFormFieldState();
}

class _ForgotFormFieldState extends State<ForgotFormField> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // Future resetPassword() async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => const Center(child: CircularProgressIndicator()),
  //   );
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: emailController.text.trim());
  //     Util.showSnackBar("Password Reset Email Sent");
  //     Navigator.of(context).popUntil((route) => route.isFirst);
  //   } on FirebaseException catch (e) {
  //     print(e.message);
  //     Util.showSnackBar(e.message);
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      child: Container(
        height: size.height * 0.18,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          validator: (value) {
            return value != null && !EmailValidator.validate(value)
                ? "Enter a valid email "
                : null;
          },
          controller: emailController,
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: AppTextFieldDecorations.emailInputDecoration,
        ),
      ),
    );
  }
}
