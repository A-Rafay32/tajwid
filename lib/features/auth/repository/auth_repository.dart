import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:tajwid/app/constants/api_urls.dart';
import 'package:tajwid/core/exceptions/exceptions.dart';
import 'package:tajwid/core/services/http_service.dart';
import 'package:tajwid/features/auth/model/auth_response.dart';

class AuthRepository {
  Future<Either<Failure, AuthResponse>> userLogin({
    required String username,
    required String password,
  }) async {
    try {
      dynamic response = await HttpService().post(
        ApiUrls.login,
        requestBody: {"username": username, "password": password},
      );
      print("response : $response");
      return Right(AuthResponse.fromMap(response as Map<String, dynamic>));
    } catch (e, stackTrace) {
      debugPrint("Error : $e\n StackTrace : $stackTrace");
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuthResponse>> userRegister({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      dynamic response = await HttpService().post(
        ApiUrls.signup,
        requestBody: requestBody,
      );
      return Right(AuthResponse.fromMap(response as Map<String, dynamic>));
    } catch (e, stackTrace) {
      debugPrint("Error : $e\n StackTrace : $stackTrace");
      return Left(Failure(message: e.toString()));
    }
  }
}
