import 'dart:convert';

WeatherMoment weatherMomentFromJson(String str) => WeatherMoment.fromJson(json.decode(str));

String weatherMomentToJson(WeatherMoment data) => json.encode(data.toJson());

class WeatherMoment {
  WeatherMoment({
    this.temperature,
    this.windDirection,
    this.windVelocity,
    this.humidity,
    this.condition,
    this.pressure,
    this.icon,
    this.sensation,
    this.date,
  });

  double temperature;
  String windDirection;
  double windVelocity;
  double humidity;
  String condition;
  double pressure;
  String icon;
  double sensation;
  DateTime date;

  factory WeatherMoment.fromJson(Map<String, dynamic> json) => WeatherMoment(
        temperature: json["temperature"] != null ? json["temperature"].toDouble() : 0.0,
        windDirection: json["wind_direction"] != null ? json["wind_direction"] : "",
        windVelocity: json["wind_velocity"] != null ? json["wind_velocity"].toDouble() : 0.0,
        humidity: json["humidity"] != null ? json["humidity"].toDouble() : 0.0,
        condition: json["condition"] != null ? json["condition"] : "",
        pressure: json["pressure"] != null ? json["pressure"].toDouble() : 0.0,
        icon: json["icon"] != null ? json["icon"] : "",
        sensation: json["sensation"] != null ? json["sensation"].toDouble() : 0.0,
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "wind_direction": windDirection,
        "wind_velocity": windVelocity,
        "humidity": humidity,
        "condition": condition,
        "pressure": pressure,
        "icon": icon,
        "sensation": sensation,
        "date": date.toIso8601String(),
      };
}
