// import 'dart:io';
// import 'package:either_dart/either.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tajwid/core/exceptions/exceptions.dart';
// import 'package:tajwid/core/utils/types.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:path/path.dart';

// class ImageService {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final ImagePicker imgPicker = ImagePicker();
//   String bucket = 'trip-testing';

//   Future<List<String>> uploadImages({
//     required String folderPath,
//     required List<String> pickedFiles,
//   }) async {
//     try {
//       final List<String> urlList = [];

//       for (var file in pickedFiles) {
//         final fileName = basename(file);
//         final filePath = "$folderPath/$fileName";

//         final fileBytes = await File(file).readAsBytes();

//         final response = await _supabase.storage
//             .from(bucket)
//             .uploadBinary(
//               filePath,
//               fileBytes,
//               fileOptions: FileOptions(contentType: 'image/jpeg', upsert: true),
//             );

//         final imageUrl = _supabase.storage.from(bucket).getPublicUrl(filePath);
//         urlList.add(imageUrl);
//       }

//       print("Images uploaded successfully.");
//       return urlList;
//     } catch (e, stackTrace) {
//       print("Upload error: $e\n$stackTrace");
//       rethrow;
//       // return Left(Failure(message: "Failed to upload images: $e"));
//     }
//   }

//   /// Upload a single image to Supabase Storage
//   FutureEither1<String> uploadImage({
//     required String folderPath,
//     ImageSource source = ImageSource.gallery,
//   }) async {
//     try {
//       final pickedFile = await imgPicker.pickImage(source: source);
//       if (pickedFile == null) {
//         throw "No image selected";
//       }

//       final fileName = basename(pickedFile.path);
//       final filePath = "$folderPath/$fileName";
//       final fileBytes = await File(pickedFile.path).readAsBytes();

//       final response = await _supabase.storage
//           .from(bucket)
//           .uploadBinary(
//             filePath,
//             fileBytes,
//             fileOptions: FileOptions(contentType: 'image/jpeg', upsert: true),
//           );

//       final imageUrl = _supabase.storage.from(bucket).getPublicUrl(filePath);

//       print("Image uploaded successfully: $imageUrl");
//       return Right(imageUrl);
//     } catch (e, stackTrace) {
//       print("Upload error: $e\n$stackTrace");
//       return Left(Failure(message: "Failed to upload image: $e"));
//     }
//   }

//   /// Pick image and return file path
//   FutureEither1<String> pickImage({required ImageSource source}) async {
//     try {
//       final pickedFile = await imgPicker.pickImage(source: source);
//       if (pickedFile != null) {
//         return Right(pickedFile.path);
//       } else {
//         throw "No image selected";
//       }
//     } catch (e, stackTrace) {
//       print("Pick image error: $e\n$stackTrace");
//       return Left(Failure(message: "Failed to pick image: $e"));
//     }
//   }
// }
