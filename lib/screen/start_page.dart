import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task5/screen/home_screen.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(59, 38, 123, 0.7),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(129, 131, 247, 0),
                  Color.fromRGBO(129, 128, 243, 0.04),
                  Color.fromRGBO(145, 0, 178, 1),
                  // Colors.purpleAccent,
                ]),
          ),
          child: Column(
            children: [
              Image.asset(
                'images/weather _))10 18.png',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Weather',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 65,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'ForeCasts',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 60,
                ),
              ),
              SizedBox(
                width: 304,
                height: 72,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) =>  HomeScreen()),
                      );
                    },
                    child: const Text(
                      'Get Start',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
