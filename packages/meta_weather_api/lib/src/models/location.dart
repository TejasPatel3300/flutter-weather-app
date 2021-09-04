import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

enum LocationType {
  @JsonValue('City')
  city,
  @JsonValue('Region')
  region,
  @JsonValue('State')
  state,
  @JsonValue('Province')
  province,
  @JsonValue('Country')
  country,
  @JsonValue('Continent')
  continent,
}

@JsonSerializable()
class Location {
  final String title;
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;
  final LocationType locationType;
  final int woeid;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  const Location({
    required this.title,
    required this.latLng,
    required this.locationType,
    required this.woeid,
  });
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });
}

class LatLngConverter implements JsonConverter<LatLng, String> {
  const LatLngConverter();

  @override
  String toJson(LatLng object) {
    return '(${object.latitude}, ${object.longitude})';
  }

  @override
  LatLng fromJson(String json) {
    final parts = json.split(',');
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }
}
