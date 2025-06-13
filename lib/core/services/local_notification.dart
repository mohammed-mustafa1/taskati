import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    // final String? payload = notificationResponse.payload;
    // if (notificationResponse.payload != null) {
    //   debugPrint('notification payload: $payload');
    // }
  }

  static Future<void> init() async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
      macOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static Future showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required tz.TZDateTime scheduledDate}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'taskati_channel_id',
          'taskati_notification_channel',
          channelDescription: 'notification_channel_for_taskati',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: null,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'payload is $id',
    );
  }

  static Future<List<PendingNotificationRequest>>
      getPendingNotifications() async =>
          flutterLocalNotificationsPlugin.pendingNotificationRequests();

  static Future<void> rescheduleNotifications() async {
    DateTime timeNow = DateTime.now();
    if (LocalStorage.taskBox.values.isNotEmpty) {
      for (var task in LocalStorage.taskBox.values) {
        if (task.isCompleted || task.endTime.isBefore(timeNow)) continue;
        if (task.startTime.isAfter(timeNow)) {
          await showScheduledNotification(
            id: task.id.hashCode,
            title: task.title,
            body: task.description,
            scheduledDate: tz.TZDateTime.from(task.startTime, tz.local),
          );
        }
        if (task.endTime.isAfter(timeNow)) {
          await showScheduledNotification(
            id: task.id.hashCode + 1,
            title: task.title,
            body: task.description,
            scheduledDate: tz.TZDateTime.from(task.endTime, tz.local),
          );
        }
      }
    }
  }

  static Future<void> cancelNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      status = await Permission.notification.request();
    }
  }
}
