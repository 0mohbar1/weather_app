part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoading extends WeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherApi weather;

  WeatherLoaded({required this.weather});

  @override
  // TODO: implement props
  List<Object?> get props => [weather];
}

class WeatherFailed extends WeatherState {
  final String message;

  WeatherFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
