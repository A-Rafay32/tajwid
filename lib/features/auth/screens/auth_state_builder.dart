import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/features/auth/provider/auth_provider.dart';
import 'package:tajwid/features/auth/screens/login_screen.dart';
import 'package:tajwid/features/home/screens/home_screen.dart';

class AuthStateBuilder extends StatefulWidget {
  const AuthStateBuilder({super.key});

  @override
  State<AuthStateBuilder> createState() => _AuthStateBuilderState();
}

class _AuthStateBuilderState extends State<AuthStateBuilder> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    context.read<AuthProvider>().getSessionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().isLoggedIn == true
        ? HomeScreen()
        : LoginScreen();
  }
}
