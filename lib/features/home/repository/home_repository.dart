import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:tajwid/app/constants/api_urls.dart';
import 'package:tajwid/core/exceptions/exceptions.dart';
import 'package:tajwid/core/services/http_service.dart';
import 'package:tajwid/core/utils/custom_types.dart';
import 'package:tajwid/features/auth/model/auth_response.dart';
import 'package:tajwid/features/home/model/comparision_result_model.dart';

class HomeRepository {
  FutureEither1<ComparisionResultModel> compare({
    required Map<String, File> files,
  }) async {
    try {
      final response = await HttpService().postMultipart(
        ApiUrls.compare,
        files: files,
      );
      return Right(
        ComparisionResultModel.fromJson(response as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      debugPrint("Error : $e\n StackTrace : $stackTrace");
      return Left(Failure(message: e.toString()));
    }
  }
}
