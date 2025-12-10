import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings =
    const InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);

    // Request permission (Android 13+)
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      print("NOTIFICATION PERMISSION: $granted");
    }
  }

  // Show immediate notification
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'daily_channel',
      'Daily Notifications',
      channelDescription: 'Daily recipe reminder',
      importance: Importance.max,
      priority: Priority.high,
    );

    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(0, title, body, details);
  }

  Timer? _dailyTimer;

  Future<void> startDailySoftReminder() async {
    _dailyTimer?.cancel();

    _dailyTimer = Timer.periodic(const Duration(days: 1), (_) {
      showNotification(
        title: "Recipe of the Day",
        body: "Отвори ја апликацијата и види го денешниот рецепт!",
      );
    });

    print("Soft daily reminder started");
  }

}