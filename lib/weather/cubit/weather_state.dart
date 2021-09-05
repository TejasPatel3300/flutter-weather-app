part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final TemperatureUnits temperatureUnits;

  WeatherState({
    this.status = WeatherStatus.initial,
    Weather? weather,
    this.temperatureUnits = TemperatureUnits.celsius,
  }) : weather = weather ?? Weather.empty;

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status, temperatureUnits, weather];
}
