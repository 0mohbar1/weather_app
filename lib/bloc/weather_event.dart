part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable{
  @override
  List<Object> get props=>[];
}
class FetchWeather extends WeatherEvent{

}
