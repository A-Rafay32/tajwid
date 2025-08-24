// import 'package:flutter/material.dart';
// import 'package:tajwid/core/extensions/routes_extenstion.dart';
// import 'package:tajwid/features/auth/screens/login_screen.dart';
// import 'package:tajwid/features/auth/screens/update_password_screen.dart';

// class AuthStateBuilder extends StatefulWidget {
//   const AuthStateBuilder({super.key});

//   @override
//   State<AuthStateBuilder> createState() => _AuthStateBuilderState();
// }

// class _AuthStateBuilderState extends State<AuthStateBuilder> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<AuthState>(
//       stream: AuthStateBuilder.supabase.auth.onAuthStateChange,
//       builder: (context, snapshot) {
//         final user = AuthStateBuilder.supabase.auth.currentUser;

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (user != null) {
//           return HomeScreen();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }
