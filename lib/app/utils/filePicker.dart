// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';

// class FilePickerService {
//   final ImagePicker imgPicker = ImagePicker();
//   List<XFile>? pickedFiles;

//   Future<String>? pickImage({required ImageSource source}) async {
//     try {
//       final pickedFile = await imgPicker.pickImage(source: source);
//       if (pickedFile != null) {
//         return (pickedFile.path);
//       } else {
//         throw "Null Image Error: Failed to pick the file";
//       }
//     } catch (e, stackTrace) {
//       print("Error : $e $stackTrace");
//       rethrow;
//     }
//   }

//   Future<String> pickFile({
//     bool allowImages = true,
//     bool allowDocuments = true,
//   }) async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type:
//             allowImages && allowDocuments
//                 ? FileType.custom
//                 : (allowImages ? FileType.image : FileType.any),
//         allowedExtensions:
//             allowImages && allowDocuments
//                 ? ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']
//                 : (allowImages
//                     ? ['jpg', 'png', 'jpeg']
//                     : ['pdf', 'doc', 'docx']),
//       );

//       if (result != null && result.files.single.path != null) {
//         return result.files.single.path!;
//       } else {
//         throw "Null File Error: Failed to pick the file";
//       }
//     } catch (e, stackTrace) {
//       print("Error: $e $stackTrace");
//       return "Failed to pick file: $e";
//     }
//   }
// }
