// // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // // // class NotificationService {
// // // //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// // // //       FlutterLocalNotificationsPlugin();

// // // //   Future<void> initialize() async {
// // // //     const AndroidInitializationSettings initializationSettingsAndroid =
// // // //         AndroidInitializationSettings('app_logo');
// // // //     const InitializationSettings initializationSettings =
// // // //         InitializationSettings(android: initializationSettingsAndroid);

// // // //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// // // //   }

// // // //   Future<void> showNotification(
// // // //       {required int id, required String title, required String body}) async {
// // // //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
// // // //         AndroidNotificationDetails(
// // // //       'tour_management_channel',
// // // //       'Tour Management Notifications',
// // // //       importance: Importance.max,
// // // //       priority: Priority.high,
// // // //       ticker: 'ticker',
// // // //     );
// // // //     const NotificationDetails platformChannelSpecifics =
// // // //         NotificationDetails(android: androidPlatformChannelSpecifics);

// // // //     await flutterLocalNotificationsPlugin.show(
// // // //       id,
// // // //       title,
// // // //       body,
// // // //       platformChannelSpecifics,
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // // class NotificationService {
// // //   final FlutterLocalNotificationsPlugin notificationsPlugin =
// // //       FlutterLocalNotificationsPlugin();

// // //   Future<void> initNotification() async {
// // //     AndroidInitializationSettings initializationSettingsAndroid =
// // //         const AndroidInitializationSettings('flutter_logo');

// // //     var initializationSettingsIOS = DarwinInitializationSettings(
// // //         requestAlertPermission: true,
// // //         requestBadgePermission: true,
// // //         requestSoundPermission: true,
// // //         onDidReceiveLocalNotification:
// // //             (int id, String? title, String? body, String? payload) async {});

// // //     var initializationSettings = InitializationSettings(
// // //         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
// // //     await notificationsPlugin.initialize(initializationSettings,
// // //         onDidReceiveNotificationResponse:
// // //             (NotificationResponse notificationResponse) async {});
// // //   }

// // //   notificationDetails() {
// // //     return const NotificationDetails(
// // //         android: AndroidNotificationDetails('channelId', 'channelName',
// // //             importance: Importance.max),
// // //         iOS: DarwinNotificationDetails());
// // //   }

// // //   Future showNotification(
// // //       {int id = 0, String? title, String? body, String? payLoad}) async {
// // //     return notificationsPlugin.show(
// // //         id, title, body, await notificationDetails());
// // //   }
// // // }

// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // class NotificationService {
// //   final FlutterLocalNotificationsPlugin notificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   Future<void> initNotification() async {
// //     AndroidInitializationSettings initializationSettingsAndroid =
// //         const AndroidInitializationSettings('app_logo');

// //     // Remove onDidReceiveLocalNotification, as it's not valid anymore.
// //     var initializationSettingsIOS = const DarwinInitializationSettings(
// //       requestAlertPermission: true,
// //       requestBadgePermission: true,
// //       requestSoundPermission: true,
// //     );

// //     var initializationSettings = InitializationSettings(
// //       android: initializationSettingsAndroid,
// //       iOS: initializationSettingsIOS,
// //     );

// //     await notificationsPlugin.initialize(initializationSettings,
// //         onDidReceiveNotificationResponse:
// //             (NotificationResponse notificationResponse) async {
// //       // Handle notification response when tapped
// //       print("Notification Tapped: ${notificationResponse.payload}");
// //     });
// //   }

// //   // notificationDetails() {
// //   //   return const NotificationDetails(
// //   //     android: AndroidNotificationDetails(
// //   //       'channelId',
// //   //       'channelName',
// //   //       importance: Importance.max,
// //   //     ),
// //   //     iOS: DarwinNotificationDetails(),
// //   //   );
// //   // }

// //   notificationDetails() {
// //     return NotificationDetails(
// //       android: AndroidNotificationDetails(
// //         'channelId',
// //         'channelName',
// //         channelDescription: 'Your channel description here', // Add description
// //         importance: Importance.max,
// //         priority: Priority.high,
// //       ),
// //       iOS: DarwinNotificationDetails(),
// //     );
// //   }

// //   Future showNotification(
// //       {int id = 0, String? title, String? body, String? payLoad}) async {
// //     print("Notification showing...");
// //     return notificationsPlugin.show(
// //         id, title, body, await notificationDetails());
// //   }
// // }

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize the notification plugin
//   Future<void> initialize(InitializationSettings initializationSettings) async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(
//             'app_logo'); // Use the app icon from assets

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true);

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // Show a notification
//   Future<void> showNotification(
//       {int id = 0, String? title, String? body}) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel_id', 'channel_name',
//             importance: Importance.high, priority: Priority.high);

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await flutterLocalNotificationsPlugin.show(
//         id, title, body, notificationDetails);
//   }
// }

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize the notification plugin
//   Future<void> initialize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(
//             '@mipmap/ic_launcher'); // Use the app icon from assets

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

// //   // Show a notification
// //   Future<void> showNotification({
// //     int id = 0,
// //     String? title,
// //     String? body,
// //   }) async {
// //     const AndroidNotificationDetails androidNotificationDetails =
// //         AndroidNotificationDetails(
// //       'channel_id',
// //       'channel_name',
// //       importance: Importance.high,
// //       priority: Priority.high,
// //     );

// //     const NotificationDetails notificationDetails =
// //         NotificationDetails(android: androidNotificationDetails);

// //     await flutterLocalNotificationsPlugin.show(
// //       id,
// //       title,
// //       body,
// //       notificationDetails,
// //     );
// //   }
// // }

//   Future<void> showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channel_id', // Channel ID
//       'channel_name', // Channel name
//       channelDescription: 'This is the channel for app notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification plugin
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Use the app icon from assets

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request notification permission for Android 13 or higher
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Show a notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id', // Channel ID
      'channel_name', // Channel name
      channelDescription: 'This is the channel for app notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}
