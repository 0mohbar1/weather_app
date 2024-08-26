import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5/bloc/weather_bloc.dart';
import 'package:task5/data/DemoApi.dart';
import 'package:task5/message.dart';
import 'package:task5/push_notivication.dart';
import 'package:task5/screen/home_screen.dart';
import 'package:task5/screen/menu_sreen.dart';
import 'firebase_options.dart';
import 'screen/start_page.dart';

final navigationKey = GlobalKey<NavigatorState>();

Future _firebaseBackgroundMessage(RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    print('Show notification Received');
  }
  print('Message from push notification is ${remoteMessage.data}');
  AwesomeNotifications().createNotificationFromJsonData(remoteMessage.data);
}

void SubscribeWeather1() async {
  await FirebaseMessaging.instance
      .subscribeToTopic("Weather1")
      .then((value) => print('Weather 1 Subscribe'));
  await FirebaseMessaging.instance.unsubscribeFromTopic('Weather1');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key1',
            title: message.notification!.title,
            body: message.notification!.body));
  });
}

void SubscribeWeather2() async {
  await FirebaseMessaging.instance
      .subscribeToTopic("Weather2")
      .then((value) => print('Weather 2 Subscribe'));

  await FirebaseMessaging.instance.unsubscribeFromTopic('Weather2');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: 'key2',
            title: message.notification!.title,
            body: message.notification!.body));
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotivication.init();
  PushNotivication.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    String payloadData = jsonEncode(remoteMessage.data);
    print('Got a message in foreground');
    if (remoteMessage.notification != null) {
      PushNotivication.showSimpleNotification(
          title: remoteMessage.notification!.title!,
          body: remoteMessage.notification!.body!,
          payload: payloadData);
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
    if (remoteMessage.notification != null) {
      print("Background Notification Tapped");
      navigationKey.currentState!
          .pushNamed('message', arguments: remoteMessage);
    }
  });
  final RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    print('Launched from terminated state');
    Future.delayed(const Duration(seconds: 1), () {
      navigationKey.currentState!
          .pushNamed('message', arguments: remoteMessage);
    });
  }
  final demoApi = DemoApi();
  runApp(MyApp(demoApi: demoApi));
}

class MyApp extends StatelessWidget {
  final DemoApi demoApi;

  MyApp({required this.demoApi});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => StartPage(),
        '/homescreen': (context, state, data) => HomeScreen(),
        '/menuscreen': (context, state, data) => MenuScreen(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(demoApi)..add(FetchWeather()),
      child: MaterialApp(
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartPage(),
        routes: {
          'message': (context) => const Message(),
        },
      ),
    );
  }
}
