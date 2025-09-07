// import 'package:either_dart/either.dart';
// import 'package:flutter/material.dart';
// import 'package:tajwid/app/constants/api_urls.dart';
// import 'package:tajwid/core/exceptions/exceptions.dart';
// import 'package:tajwid/core/services/http_service.dart';

// class UserRepository {
//   UserRepository({required this.httpService});

//   final HttpService httpService;

//   Future<GetCustomerModel> getCustomerData({required String id}) async {
//     try {
//       dynamic response = await httpService.get(ApiUrls.getCustomer(id));
//       print(response);
//       return GetCustomerModel.fromMap(response as Map<String, dynamic>);
//     } catch (e, stackTrace) {
//       debugPrint("Error : $e\n StackTrace : $stackTrace");
//       rethrow;
//     }
//   }

//   FutureEither1<dynamic> updateCustomerData(
//     String id,
//     Map<String, dynamic> updateFields,
//   ) async {
//     try {
//       dynamic response = await httpService.patch(
//         ApiUrls.updateCustomer(id),
//         requestBody: updateFields,
//       );
//       print(response);
//       return Right(Success(message: "Information updated successfully"));
//     } catch (e, stackTrace) {
//       debugPrint("Error : $e\n StackTrace : $stackTrace");
//       return Left(Fageilure(message: e.toString()));
//     }
//   }
// }
