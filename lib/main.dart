import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tajwid/app/themes/app_themes.dart';
import 'package:tajwid/core/services/share_pref.dart';
import 'package:tajwid/features/auth/provider/auth_provider.dart';
import 'package:tajwid/features/auth/screens/auth_state_builder.dart';
import 'package:tajwid/features/home/provider/home_provider.dart';
import 'package:tajwid/features/home/screens/comparision_result_screen.dart';
import 'package:tajwid/features/home/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPrefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomeProvider()),
            ChangeNotifierProvider(create: (context) => AuthProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tajwid',
            theme: AppThemes().theme,
            home: AuthStateBuilder(),
          ),
        );
      },
    );
  }
}
