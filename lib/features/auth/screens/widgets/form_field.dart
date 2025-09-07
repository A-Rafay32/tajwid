import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";
import "package:tajwid/app/themes/app_colors.dart";
import "package:tajwid/app/themes/app_text_field_themes.dart";
import "package:tajwid/features/auth/screens/widgets/custom_text_field.dart";

class AuthFormField extends StatefulWidget {
  const AuthFormField({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool isObscure = false;

  void setObscureText() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          validator: (value) {
            return value != null && value.length < 6
                ? "Enter a valid username"
                : null;
          },
          controller: widget.usernameController,
          inputDecoration: AppTextFieldDecorations.genericInputDecoration(
            label: "Username",
          ),
        ),
        const SizedBox(height: 40),
        CustomTextField(
          validator: (value) {
            return value != null && value.length < 6
                ? "Enter min 6 characters "
                : null;
          },
          obscureText: isObscure,
          controller: widget.passwordController,
          inputDecoration: AppTextFieldDecorations.passwordInputDecoration(
            isObscure,
            setObscureText,
          ),
        ),
      ],
    );
  }
}
