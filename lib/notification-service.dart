import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await plugin.initialize(const InitializationSettings(android: android));

    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  ///test
  static Future<void> showTestNotification() async {
    await plugin.show(
      999,
      "📚 Bodmas Education",
      "Notification working successfully 🚀",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meeting_channel',
          'Meeting Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
  ///test
  static Future<void> showTestNotificationAfter5Sec() async {

    await Future.delayed(
      const Duration(seconds: 5),
    );

    await plugin.show(
      999,
      "📚 Bodmas Education",
      "5 second test successful 🚀",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meeting_channel',
          'Meeting Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }



  static Future<void> scheduleMeetingReminder({
    required int id,
    required DateTime meetingTime,
    required String course,
  }) async {
    final oneHourBefore = meetingTime.subtract(const Duration(hours: 1));

    final thirtyMinBefore = meetingTime.subtract(const Duration(minutes: 30));

    if (oneHourBefore.isAfter(DateTime.now())) {
      await plugin.zonedSchedule(
        id,
        "📚 Bodmas Education",
        "$course starts in 1 hour",
        tz.TZDateTime.from(oneHourBefore, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'meeting_channel',
            'Meeting Reminder',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }

    if (thirtyMinBefore.isAfter(DateTime.now())) {
      await plugin.zonedSchedule(
        id + 1000,
        "⏰ Upcoming Meeting",
        "$course starts in 30 minutes",
        tz.TZDateTime.from(thirtyMinBefore, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'meeting_channel',
            'Meeting Reminder',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }

    await plugin.zonedSchedule(
      id + 2000,
      "🎥 Meeting Started",
      "Your meeting is live now.",
      tz.TZDateTime.from(meetingTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meeting_channel',
          'Meeting Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
