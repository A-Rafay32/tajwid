// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class FirebaseService {
//   static init() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print("token : $token");

//     final userId = Supabase.instance.client.auth.currentUser?.id ?? "";
//     await Supabase.instance.client.from('profiles').upsert({
//       'id': userId,
//       'fcm_token': token,
//     });
//   }
// }
