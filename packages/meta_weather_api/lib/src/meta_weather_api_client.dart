import 'dart:convert';

import 'package:meta_weather_api/meta_weather_api.dart';
import 'package:http/http.dart' as http;

class LocationIdRequestFailure implements Exception {}

class LocationFoundFailure implements Exception {}

class WeatherRequestFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}

class MetaWeatherApiClient {
  static const _baseUrl = 'www.metaweather.com';
  final http.Client _client;

  MetaWeatherApiClient({http.Client? httpClient})
      : _client = httpClient ?? http.Client();

  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrl,
      '/api/location/search',
      <String, String>{'query': query},
    );

    final locationResponse = await _client.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationIdRequestFailure();
    }

    final locationJson = jsonDecode(locationResponse.body) as List;

    if (locationJson.isEmpty) {
      throw LocationFoundFailure();
    }

    return Location.fromJson(locationJson.first as Map<String, dynamic>);
  }

  Future<Weather> getWeather(int locationId) async {
    final weatherRequest = Uri.https(_baseUrl, '/api/location/$locationId');
    final weatherResponse = await _client.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['consolidated_weather'] as List;

    if (weatherJson.isEmpty) {
      throw WeatherNotFoundFailure();
    }

    return Weather.fromJson(weatherJson.first as Map<String, dynamic>);
  }
}
