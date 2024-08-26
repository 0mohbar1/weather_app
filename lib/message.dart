import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task5/main.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Map payload = {};

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    if (message is RemoteMessage) {
      payload = message.data;
    }
    if (message is NotificationResponse) {
      payload = jsonDecode(message.payload!);
    }
  //  final mess = ModalRoute.of(context)!.settings.arguments ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(payload.toString()),
            ElevatedButton(onPressed: (){SubscribeWeather1();}, child: Text('Weather 1')),

            ElevatedButton(onPressed: (){SubscribeWeather2();}, child: Text('Weather 2')),
          ],
        ),
      ),
    );
  }
}
