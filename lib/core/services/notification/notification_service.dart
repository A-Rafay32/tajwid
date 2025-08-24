// import 'dart:async';
// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:tajwid/core/services/notification/app_notification_data.dart';
// import 'package:tajwid/core/services/notification/notification_data.dart';

// class NotificationController extends ChangeNotifier {
//   String fcmToken = '';
//   List<NotificationData> notifications = [];

//   StreamSubscription<RemoteMessage>? foregroundInteraction;
//   StreamSubscription<RemoteMessage>? backgroundInteraction;
//   final localNotifications = FlutterLocalNotificationsPlugin();
//   final firebaseMessaging = FirebaseMessaging.instance;

//   NotificationController(
//     // {required this.dbApi}
//   ) {
//     initController();
//   }

//   Future<void> initController() async {
//     await firebaseMessaging.requestPermission();
//     await firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     const androidSettings = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//     final initSettings = InitializationSettings(android: androidSettings);
//     await localNotifications.initialize(initSettings);

//     fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
//     log('fcmToken: $fcmToken');
//     print('fcmToken: $fcmToken');

//     await localNotifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(AppNotificationData.channel);
//     startListening();
//   }

//   void startListening() {
//     _handleForegroundInteraction();
//     _handleBackgroundInteraction();
//     _setupBackgroundNotification();
//     _setupForegroundNotification();
//     // _catchBackgroundNotifications(message);
//     // _catchForegroundNotifications(message);
//   }

//   void handleInteraction(RemoteMessage message) async {
//     print("Title : ${message.notification?.title}");
//     print("Body : ${message.notification?.body}");
//     print("Payload : ${message.data}");
//     log('handleInteraction: $message');
//     // final  session = dbApi.getSession();
//     // if (session == null) return;
//     await Future.delayed(Duration.zero);
//     // nav.context.popTillFirst();
//     // nav.context.read<BottomBarController>().goToNotifications();
//   }

//   void handleNotification(RemoteMessage message) {
//     final notification = NotificationData.fromRemoteMessage(message);
//     notifications.add(notification);
//     print("Notification $notification added to List");
//     log('handleNotification');
//     notifyListeners();
//   }

//   void sendNotifications(String title, String body) async {
//     NotificationDetails notificationDetails =
//         AppNotificationData.notificationDetails;
//     NotificationData notification = NotificationData(
//       title: title,
//       body: body,
//       data: {},
//     );
//     notifications.add(notification);
//     print(notifications);
//     localNotifications.show(0, title, body, notificationDetails);
//     notifyListeners();
//   }

//   void _handleForegroundInteraction() async {
//     final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage == null) return;
//     log('_handleForegroundInteraction');
//     handleInteraction(initialMessage);
//   }

//   void _handleBackgroundInteraction() {
//     backgroundInteraction?.cancel();
//     backgroundInteraction = FirebaseMessaging.onMessageOpenedApp.listen((_) {});
//     backgroundInteraction!.onData(handleInteraction);
//   }

//   void _setupBackgroundNotification() {
//     FirebaseMessaging.onBackgroundMessage(_catchBackgroundNotifications);
//   }

//   void _setupForegroundNotification() {
//     // foregroundInteraction?.cancel();
//     // foregroundInteraction = FirebaseMessaging.onMessage.listen((_) {});
//     // foregroundInteraction!.onData(_catchForegroundNotifications);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(
//         "🔔 Foreground Notification received: ${message.notification?.title}",
//       );

//       final notification = message.notification;
//       final android = message.notification?.android;

//       if (notification != null && android != null) {
//         localNotifications.show(
//           0,
//           notification.title,
//           notification.body,
//           AppNotificationData.notificationDetails,
//           payload: '',
//         );
//       }

//       // Optional: Add to local notification list or custom handling
//       handleNotification(message);
//     });
//   }

//   void _catchForegroundNotifications(message) async {
//     final notification = message.notification;
//     if (notification == null) return;
//     log('_catchForegroundNotifications');

//     handleNotification(message);
//     localNotifications.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       AppNotificationData.notificationDetails,
//     );
//   }

//   @override
//   void dispose() {
//     foregroundInteraction?.cancel();
//     backgroundInteraction?.cancel();
//     // dbApi.deleteFcm();
//     super.dispose();
//   }

//   @pragma('vm:entry-point')
//   Future<void> _catchBackgroundNotifications(RemoteMessage message) async {}
// }
