import 'package:flutter/material.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/snackbar_ext.dart';
import 'package:tajwid/core/services/loading.dart';
import 'package:tajwid/core/services/share_pref.dart';
import 'package:tajwid/features/auth/model/auth_response.dart';
import 'package:tajwid/features/auth/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  static String token = '';

  Loading loading = Loading();
  bool? isLoggedIn = false;

  void setLoading(bool isLoading) {
    loading.setLoading(isLoading);
    notifyListeners();
  }

  void getSessionInfo() async {
    isLoggedIn = await UserPrefs.getUserSession();
    print("isLoggedIn : $isLoggedIn");
    notifyListeners();
  }

  void loadData() async {
    token = await UserPrefs.getToken();
    print("Data Loaded!");
    notifyListeners();
  }

  AuthResponse? authResponse;
  void login({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    setLoading(true);
    final result = await AuthRepository().userLogin(
      username: username,
      password: password,
    );
    setLoading(false);

    result.fold((left) => context.showSnackBar(left.message), (right) async {
      token = right.accessToken;
      print("token : $token ");
      await UserPrefs.setUserSession(true);
      await UserPrefs.setToken(token);
      authResponse = right;
      isLoggedIn = true;
      notifyListeners();
    });
  }

  void register({
    required String email,
    required String password,
    required String userName,
    required BuildContext context,
  }) async {
    setLoading(true);
    final result = await AuthRepository().userRegister(
      requestBody: {"username": userName, "email": email, "password": password},
    );
    setLoading(false);
    result.fold((left) => context.showSnackBar(left.message), (right) async {
      context.pop();
      token = right.accessToken;
      print("token : $token ");
      await UserPrefs.setUserSession(true);
      await UserPrefs.setToken(token);
      authResponse = right;
      isLoggedIn = true;
      notifyListeners();
    });
  }

  void logOut() async {
    await UserPrefs.setUserSession(false);
    await UserPrefs.delToken();
    isLoggedIn = false;
    notifyListeners();
  }
}
