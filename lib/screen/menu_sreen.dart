import 'package:flutter/material.dart';
import 'package:task5/data/apiweather.dart';
import 'package:task5/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
  }

  int startIndex = 0;
  int endIndex = 3;
  bool isSecondRowVisible = false;
  late final WeatherApi weatherApi;

  @override
  Widget build(BuildContext context) {
    final List<Widget> item = [
      buildSizedBox('Mod'),
      buildSizedBox('Tue'),
      buildSizedBox('Wed'),
      buildSizedBox('Thu'),
      buildSizedBox('Fri'),
      buildSizedBox('Sat'),
      buildSizedBox('Sun'),
    ];
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
                width: double.infinity,
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
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      state.weather.location!.name.toString(),
                      style: buildTextStyle(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Max:${state.weather.current!.windMph.toString()}',
                            style: buildTextStyle()),
                        const SizedBox(
                          width: 30,
                        ),
                        Text('Min:${state.weather.current!.windKph.toString()}',
                            style: buildTextStyle()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '7-Days Forecasts',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
if(startIndex>0){
  startIndex--;
  endIndex--;
}
                    });
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          ),
                          for (int i = startIndex; i <= endIndex; i++) item[i],
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
if(endIndex<item.length-1){
  startIndex++;
  endIndex++;
}
          });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0),
                      child: SizedBox(
                        width: 352,
                        height: 172,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromRGBO(62, 45, 143, 1),
                                  //         Color.fromRGBO(143, 37, 169, 0.6),
                                  Color.fromRGBO(157, 82, 172, 1),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/bom.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'AIR QUALITY',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '3-Low Health Risk',
                                    style: TextStyle(
                                        fontSize: 28, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      // borderRadius: BorderRadius.circular(18.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color.fromRGBO(54, 42, 132, 1),
                                          Color.fromRGBO(128, 91, 202, 0.82),
                                          Color.fromRGBO(189, 8, 252, 1),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'See more',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                      child: Row(
                        children: [
                          buildExpanded1(),
                          buildExpanded1(),
                        ],
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                              );
                            },
                            icon: const Icon(
                              Icons.menu_outlined,
                              size: 40,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
            );
          }
          return Text('data');
        },
      ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(fontSize: 24, color: Colors.white);
  }

  Row buildFirstRow() {
    return Row(
      children: [
        buildSizedBox('Mod'),
        buildSizedBox('Tue'),
        buildSizedBox('Wed'),
        buildSizedBox('Thu'),
      ],
    );
  }

  Row buildSecondRow() {
    return Row(
      children: [
        buildSizedBox('Thu'),
        buildSizedBox('Fri'),
        buildSizedBox('Sat'),
        buildSizedBox('Sun'),
      ],
    );
  }

  Expanded buildExpanded1() {
    return Expanded(
      child: SizedBox(
        width: 161,
        height: 140,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              gradient: buildLinearGradient(
                Color.fromRGBO(62, 45, 143, 1),
                Color.fromRGBO(157, 82, 172, 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '19',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Image.asset(
                    'images/weather _))10 18.png',
                    width: 90,
                    height: 60,
                  ),
                  Text(
                    '15.00',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient buildLinearGradient(Color color1, Color color2) {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [color1, color2],
    );
  }

  SizedBox buildSizedBox(String day) {
    return SizedBox(
      width: 82,
      height: 172,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            gradient: buildLinearGradient(
              const Color.fromRGBO(41, 14, 139, 1.0),
              const Color.fromRGBO(145, 0, 178, 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '19',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Image.asset(
                  'images/Moon cloud mid rain.png',
                  width: 90,
                  height: 30,
                ),
                Text(
                  day,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
