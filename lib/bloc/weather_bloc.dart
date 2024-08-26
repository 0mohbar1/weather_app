import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task5/data/apiweather.dart';

import '../data/DemoApi.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final DemoApi demoApi;

  WeatherBloc(this.demoApi) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        final WeatherApi weatherapi = await demoApi.getData();

        emit(WeatherLoaded(weather: weatherapi));
      } catch (e) {
        emit(WeatherFailed(message: e.toString()));
        print(e.toString());
      }
    });
  }
}
