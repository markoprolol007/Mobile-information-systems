import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'services/meal_service.dart';
import 'services/notification_service.dart';

import 'screens/categories_screen.dart';
import 'screens/meals_by_category_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Handle FCM messages in background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService().showNotification(
    title: message.notification?.title ?? "Recipe App",
    body: message.notification?.body ?? "",
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Init local notifications
  await NotificationService().init();
  await NotificationService().startDailySoftReminder();


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationService().showNotification(
      title: message.notification?.title ?? "Recipe App",
      body: message.notification?.body ?? "",
    );
  });

  // Ask for user permission
  await FirebaseMessaging.instance.requestPermission();

  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealService(),
      child: MaterialApp(
        title: 'Рецепти',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: CategoriesScreen(),
        routes: {
          MealsByCategoryScreen.routeName: (_) => MealsByCategoryScreen(),
          MealDetailScreen.routeName: (_) => MealDetailScreen(),
        },
      ),
    );
  }
}
