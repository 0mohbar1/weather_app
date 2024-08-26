import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5/data/apiweather.dart';
import 'package:task5/screen/menu_sreen.dart';
import 'package:weather/weather.dart';
import 'package:weather/weather.dart';

import '../bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
  }

  late final WeatherApi weatherApi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          } else if (state is WeatherLoaded) {
            return SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(129, 131, 247, 0),
                        Color.fromRGBO(129, 128, 243, 0.04),
                        Colors.purpleAccent,
                      ]),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'images/weather _))10 18.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Text(
                      state.weather.current!.tempC.toString(),
                      style: TextStyle(fontSize: 45, color: Colors.white),
                    ),
                    const Text(
                      'precipitation',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Max:${state.weather.current!.windKph.toString()}',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white)),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('Min:${state.weather.current!.windMph.toString()}',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'images/House.png',
                      width: 300,
                      height: 150,
                    ),                    Spacer(),

                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color.fromRGBO(129, 131, 247, 0),
                              Color.fromRGBO(129, 128, 243, 0.04),
                              Color.fromRGBO(145, 0, 178, 1),
                            ]),
                      ),
                      width: double.infinity,
                      height: 170,
                      child: Card(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Today',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Text('July,21',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        state.weather.current!.tempC.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Image.asset(
                                        'images/weather _))10 18.png',
                                        width: 70,
                                        height: 50,
                                      ),
                                      Text(
                                        '15.00',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                buildExpanded(),
                                buildExpanded(),
                                buildExpanded(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildIconButton(Icons.location_on_outlined),
                        buildIconButton(Icons.add_circle_outline),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>  MenuScreen()),
                            );
                          },
                          icon: const Icon(
                            Icons.menu_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is WeatherFailed) {
            return Center(
                child: Text('messssssssssssssssssssage ${state.message}'));
          }
          return Center(child: Text('Faileeeeeeeeeeeeeeeeeeeed'));
        },
      ),
    );
    ;
  }

  IconButton buildIconButton(IconData icon) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: Column(
        children: [
          Text(
            '19',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Image.asset(
            'images/moon.png',
            width: 50,
            height: 50,
          ),
          Text(
            '15.00',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
