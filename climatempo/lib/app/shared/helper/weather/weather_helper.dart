import 'dart:convert';

import 'package:climatempo_app/app/shared/helper/weather/weather_moment_helper.dart';

WeatherHelper weatherHelperFromJson(String str) => WeatherHelper.fromJson(json.decode(str));

String weatherHelperToJson(WeatherHelper data) => json.encode(data.toJson());

class WeatherHelper {
  WeatherHelper({
    this.id,
    this.name,
    this.state,
    this.country,
    this.meteogram,
    this.data,
    this.moment,
  });

  int id;
  String name;
  String state;
  String country;
  String meteogram;
  WeatherMoment moment;
  List<Datum> data;

  factory WeatherHelper.fromJson(Map<String, dynamic> json) => WeatherHelper(
        id: json["id"],
        name: json["name"] != null ? json["name"] : "",
        state: json["state"] != null ? json["state"] : "",
        country: json["country"] != null ? json["country"] : "",
        meteogram: json["meteogram"] != null ? json["meteogram"] : "",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "country": country,
        "meteogram": meteogram,
        "moment": moment,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.date,
    this.dateBr,
    this.humidity,
    this.rain,
    this.wind,
    this.uv,
    this.thermalSensation,
    this.textIcon,
    this.temperature,
    this.cloudCoverage,
    this.sun,
  });

  DateTime date;
  String dateBr;
  Humidity humidity;
  Rain rain;
  Wind wind;
  Uv uv;
  ThermalSensation thermalSensation;
  TextIcon textIcon;
  Temperature temperature;
  CloudCoverage cloudCoverage;
  Sun sun;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: DateTime.parse(
          json["date"] != null ? json["date"] : DateTime.now().toString(),
        ),
        dateBr: json["date_br"] != null ? json["date_br"] : "",
        humidity: Humidity.fromJson(json["humidity"]),
        rain: Rain.fromJson(json["rain"]),
        wind: Wind.fromJson(json["wind"]),
        uv: Uv.fromJson(json["uv"]),
        thermalSensation: ThermalSensation.fromJson(json["thermal_sensation"]),
        textIcon: TextIcon.fromJson(json["text_icon"]),
        temperature: Temperature.fromJson(json["temperature"]),
        cloudCoverage: CloudCoverage.fromJson(json["cloud_coverage"]),
        sun: Sun.fromJson(json["sun"]),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "date_br": dateBr,
        "humidity": humidity.toJson(),
        "rain": rain.toJson(),
        "wind": wind.toJson(),
        "uv": uv.toJson(),
        "thermal_sensation": thermalSensation.toJson(),
        "text_icon": textIcon.toJson(),
        "temperature": temperature.toJson(),
        "cloud_coverage": cloudCoverage.toJson(),
        "sun": sun.toJson(),
      };
}

class CloudCoverage {
  CloudCoverage({
    this.low,
    this.mid,
    this.high,
    this.dawn,
    this.morning,
    this.afternoon,
    this.night,
  });

  double low;
  double mid;
  double high;
  DawnCloudCoverage dawn;
  MorningCloudCoverage morning;
  AfternoonCloudCoverage afternoon;
  NightCloudCoverage night;

  factory CloudCoverage.fromJson(Map<String, dynamic> json) => CloudCoverage(
        low: json["low"] != null ? json["low"].toDouble() : 0.0,
        mid: json["mid"] != null ? json["mid"].toDouble() : 0.0,
        high: json["high"] != null ? json["high"].toDouble() : 0.0,
        dawn: DawnCloudCoverage.fromJson(json["dawn"]),
        morning: MorningCloudCoverage.fromJson(json["morning"]),
        afternoon: AfternoonCloudCoverage.fromJson(json["afternoon"]),
        night: NightCloudCoverage.fromJson(json["night"]),
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "mid": mid,
        "high": high,
        "dawn": dawn.toJson(),
        "morning": morning.toJson(),
        "afternoon": afternoon.toJson(),
        "night": night.toJson(),
      };
}

class DawnCloudCoverage {
  DawnCloudCoverage({
    this.low,
    this.mid,
    this.high,
  });

  double low;
  double mid;
  double high;

  factory DawnCloudCoverage.fromJson(Map<String, dynamic> json) => DawnCloudCoverage(
        low: json["low"] != null ? json["low"].toDouble() : 0.0,
        mid: json["mid"] != null ? json["mid"].toDouble() : 0.0,
        high: json["high"] != null ? json["high"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "mid": mid,
        "high": high,
      };
}

class MorningCloudCoverage {
  MorningCloudCoverage({
    this.low,
    this.mid,
    this.high,
  });

  double low;
  double mid;
  double high;

  factory MorningCloudCoverage.fromJson(Map<String, dynamic> json) => MorningCloudCoverage(
        low: json["low"] != null ? json["low"].toDouble() : 0.0,
        mid: json["mid"] != null ? json["mid"].toDouble() : 0.0,
        high: json["high"] != null ? json["high"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "mid": mid,
        "high": high,
      };
}

class NightCloudCoverage {
  NightCloudCoverage({
    this.low,
    this.mid,
    this.high,
  });

  double low;
  double mid;
  double high;

  factory NightCloudCoverage.fromJson(Map<String, dynamic> json) => NightCloudCoverage(
        low: json["low"] != null ? json["low"].toDouble() : 0.0,
        mid: json["mid"] != null ? json["mid"].toDouble() : 0.0,
        high: json["high"] != null ? json["high"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "mid": mid,
        "high": high,
      };
}

class AfternoonCloudCoverage {
  AfternoonCloudCoverage({
    this.low,
    this.mid,
    this.high,
  });

  double low;
  double mid;
  double high;

  factory AfternoonCloudCoverage.fromJson(Map<String, dynamic> json) => AfternoonCloudCoverage(
        low: json["low"] != null ? json["low"].toDouble() : 0.0,
        mid: json["mid"] != null ? json["mid"].toDouble() : 0.0,
        high: json["high"] != null ? json["high"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "mid": mid,
        "high": high,
      };
}

class Humidity {
  Humidity({
    this.min,
    this.max,
    this.dawn,
    this.morning,
    this.afternoon,
    this.night,
  });

  double min;
  double max;
  DawnHumidity dawn;
  MorningHumidity morning;
  AfternoonHumidity afternoon;
  NightHumidity night;

  factory Humidity.fromJson(Map<String, dynamic> json) => Humidity(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
        dawn: DawnHumidity.fromJson(json["dawn"]),
        morning: MorningHumidity.fromJson(json["morning"]),
        afternoon: AfternoonHumidity.fromJson(json["afternoon"]),
        night: NightHumidity.fromJson(json["night"]),
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
        "dawn": dawn.toJson(),
        "morning": morning.toJson(),
        "afternoon": afternoon.toJson(),
        "night": night.toJson(),
      };
}

class NightHumidity {
  NightHumidity({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory NightHumidity.fromJson(Map<String, dynamic> json) => NightHumidity(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class AfternoonHumidity {
  AfternoonHumidity({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory AfternoonHumidity.fromJson(Map<String, dynamic> json) => AfternoonHumidity(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class MorningHumidity {
  MorningHumidity({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory MorningHumidity.fromJson(Map<String, dynamic> json) => MorningHumidity(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class DawnHumidity {
  DawnHumidity({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory DawnHumidity.fromJson(Map<String, dynamic> json) => DawnHumidity(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class Temperature {
  Temperature({
    this.min,
    this.max,
    this.dawn,
    this.morning,
    this.afternoon,
    this.night,
  });

  double min;
  double max;
  DawnTemperature dawn;
  MorningTemperature morning;
  AfternoonTemperature afternoon;
  NightTemperature night;

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
        dawn: DawnTemperature.fromJson(json["dawn"]),
        morning: MorningTemperature.fromJson(json["morning"]),
        afternoon: AfternoonTemperature.fromJson(json["afternoon"]),
        night: NightTemperature.fromJson(json["night"]),
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
        "dawn": dawn.toJson(),
        "morning": morning.toJson(),
        "afternoon": afternoon.toJson(),
        "night": night.toJson(),
      };
}

class NightTemperature {
  NightTemperature({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory NightTemperature.fromJson(Map<String, dynamic> json) => NightTemperature(
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class AfternoonTemperature {
  AfternoonTemperature({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory AfternoonTemperature.fromJson(Map<String, dynamic> json) => AfternoonTemperature(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class MorningTemperature {
  MorningTemperature({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory MorningTemperature.fromJson(Map<String, dynamic> json) => MorningTemperature(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class DawnTemperature {
  DawnTemperature({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory DawnTemperature.fromJson(Map<String, dynamic> json) => DawnTemperature(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class ThermalSensation {
  ThermalSensation({
    this.min,
    this.max,
  });

  double min;
  double max;

  factory ThermalSensation.fromJson(Map<String, dynamic> json) => ThermalSensation(
        min: json["min"] != null ? json["min"].toDouble() : 0.0,
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class Rain {
  Rain({
    this.probability,
    this.precipitation,
  });

  double probability;
  double precipitation;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        probability: json["probability"] != null ? json["probability"].toDouble() : 0.0,
        precipitation: json["precipitation"] != null ? json["precipitation"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "probability": probability,
        "precipitation": precipitation,
      };
}

class Sun {
  Sun({
    this.sunrise,
    this.sunset,
  });

  String sunrise;
  String sunset;

  factory Sun.fromJson(Map<String, dynamic> json) => Sun(
        sunrise: json["sunrise"] != null ? json["sunrise"] : "",
        sunset: json["sunset"] != null ? json["sunrise"] : "",
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class TextIcon {
  TextIcon({
    this.icon,
    this.text,
  });

  Icon icon;
  Text text;

  factory TextIcon.fromJson(Map<String, dynamic> json) => TextIcon(
        icon: Icon.fromJson(json["icon"]),
        text: Text.fromJson(json["text"]),
      );

  Map<String, dynamic> toJson() => {
        "icon": icon.toJson(),
        "text": text.toJson(),
      };
}

class Icon {
  Icon({
    this.dawn,
    this.morning,
    this.afternoon,
    this.night,
    this.day,
    this.reduced,
  });

  String dawn;
  String morning;
  String afternoon;
  String night;
  String day;
  String reduced;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        dawn: json["dawn"] != null ? json["dawn"] : "",
        morning: json["morning"] != null ? json["morning"] : "",
        afternoon: json["afternoon"] != null ? json["afternoon"] : "",
        night: json["night"] != null ? json["night"] : "",
        day: json["day"] == null ? "" : json["day"],
        reduced: json["reduced"] == "" ? null : json["reduced"],
      );

  Map<String, dynamic> toJson() => {
        "dawn": dawn,
        "morning": morning,
        "afternoon": afternoon,
        "night": night,
        "day": day == null ? null : day,
        "reduced": reduced == null ? null : reduced,
      };
}

class Phrase {
  Phrase({
    this.dawn,
    this.morning,
    this.afternoon,
    this.night,
    this.day,
    this.reduced,
  });

  String dawn;
  String morning;
  String afternoon;
  String night;
  String day;
  String reduced;

  factory Phrase.fromJson(Map<String, dynamic> json) => Phrase(
        dawn: json["dawn"] != null ? json["dawn"] : "",
        morning: json["morning"] != null ? json["morning"] : "",
        afternoon: json["afternoon"] != null ? json["afternoon"] : "",
        night: json["night"] != null ? json["night"] : "",
        day: json["day"] == null ? "" : json["day"],
        reduced: json["reduced"] == "" ? null : json["reduced"],
      );

  Map<String, dynamic> toJson() => {
        "dawn": dawn,
        "morning": morning,
        "afternoon": afternoon,
        "night": night,
        "day": day == null ? null : day,
        "reduced": reduced == null ? null : reduced,
      };
}

class Text {
  Text({
    this.pt,
    this.en,
    this.es,
    this.phrase,
  });

  String pt;
  String en;
  String es;
  Phrase phrase;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        pt: json["pt"] != null ? json["pt"] : "",
        en: json["en"] != null ? json["en"] : "",
        es: json["es"] != null ? json["es"] : "",
        phrase: Phrase.fromJson(json["phrase"]),
      );

  Map<String, dynamic> toJson() => {
        "pt": pt,
        "en": en,
        "es": es,
        "phrase": phrase.toJson(),
      };
}

class Uv {
  Uv({
    this.max,
  });

  double max;

  factory Uv.fromJson(Map<String, dynamic> json) => Uv(
        max: json["max"] != null ? json["max"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "max": max,
      };
}

class Wind {
  Wind({
    this.velocityMin,
    this.velocityMax,
    this.velocityAvg,
    this.gustMax,
    this.directionDegrees,
    this.direction,
    this.dawn,
    this.morning,
    this.afternoon,
    this.night,
  });

  double velocityMin;
  double velocityMax;
  double velocityAvg;
  double gustMax;
  double directionDegrees;
  String direction;
  DawnWind dawn;
  MorningWind morning;
  AfternoonWind afternoon;
  NightWind night;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        velocityMin: json["velocity_min"] != null ? json["velocity_min"].toDouble() : 0.0,
        velocityMax: json["velocity_max"] != null ? json["velocity_max"].toDouble() : 0.0,
        velocityAvg: json["velocity_avg"] != null ? json["velocity_avg"].toDouble() : 0.0,
        gustMax: json["gust_max"] != null ? json["gust_max"].toDouble() : 0.0,
        directionDegrees: json["direction_degrees"] != null ? json["direction_degrees"].toDouble() : 0.0,
        direction: json["direction"] != null ? json["direction"] : "",
        dawn: DawnWind.fromJson(json["dawn"]),
        morning: MorningWind.fromJson(json["morning"]),
        afternoon: AfternoonWind.fromJson(json["afternoon"]),
        night: NightWind.fromJson(json["night"]),
      );

  Map<String, dynamic> toJson() => {
        "velocity_min": velocityMin,
        "velocity_max": velocityMax,
        "velocity_avg": velocityAvg,
        "gust_max": gustMax,
        "direction_degrees": directionDegrees,
        "direction": direction,
        "dawn": dawn.toJson(),
        "morning": morning.toJson(),
        "afternoon": afternoon.toJson(),
        "night": night.toJson(),
      };
}

class DawnWind {
  DawnWind({
    this.direction,
    this.directionDegrees,
    this.gustMax,
    this.velocityMax,
    this.velocityAvg,
  });

  String direction;
  double directionDegrees;
  double gustMax;
  double velocityMax;
  double velocityAvg;

  factory DawnWind.fromJson(Map<String, dynamic> json) => DawnWind(
        direction: json["direction"] != null ? json["direction"] : "",
        directionDegrees: json["direction_degrees"] != null ? json["direction_degrees"].toDouble() : 0.0,
        gustMax: json["gust_max"] != null ? json["gust_max"].toDouble() : 0.0,
        velocityMax: json["velocity_max"] != null ? json["velocity_max"].toDouble() : 0.0,
        velocityAvg: json["velocity_avg"] != null ? json["velocity_avg"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "direction_degrees": directionDegrees,
        "gust_max": gustMax,
        "velocity_max": velocityMax,
        "velocity_avg": velocityAvg,
      };
}

class MorningWind {
  MorningWind({
    this.direction,
    this.directionDegrees,
    this.gustMax,
    this.velocityMax,
    this.velocityAvg,
  });

  String direction;
  double directionDegrees;
  double gustMax;
  double velocityMax;
  double velocityAvg;

  factory MorningWind.fromJson(Map<String, dynamic> json) => MorningWind(
        direction: json["direction"] != null ? json["direction"] : "",
        directionDegrees: json["direction_degrees"] != null ? json["direction_degrees"].toDouble() : 0.0,
        gustMax: json["gust_max"] != null ? json["gust_max"].toDouble() : 0.0,
        velocityMax: json["velocity_max"] != null ? json["velocity_max"].toDouble() : 0.0,
        velocityAvg: json["velocity_avg"] != null ? json["velocity_avg"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "direction_degrees": directionDegrees,
        "gust_max": gustMax,
        "velocity_max": velocityMax,
        "velocity_avg": velocityAvg,
      };
}

class NightWind {
  NightWind({
    this.direction,
    this.directionDegrees,
    this.gustMax,
    this.velocityMax,
    this.velocityAvg,
  });

  String direction;
  double directionDegrees;
  double gustMax;
  double velocityMax;
  double velocityAvg;

  factory NightWind.fromJson(Map<String, dynamic> json) => NightWind(
        direction: json["direction"] != null ? json["direction"] : "",
        directionDegrees: json["direction_degrees"] != null ? json["direction_degrees"].toDouble() : 0.0,
        gustMax: json["gust_max"] != null ? json["gust_max"].toDouble() : 0.0,
        velocityMax: json["velocity_max"] != null ? json["velocity_max"].toDouble() : 0.0,
        velocityAvg: json["velocity_avg"] != null ? json["velocity_avg"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "direction_degrees": directionDegrees,
        "gust_max": gustMax,
        "velocity_max": velocityMax,
        "velocity_avg": velocityAvg,
      };
}

class AfternoonWind {
  AfternoonWind({
    this.direction,
    this.directionDegrees,
    this.gustMax,
    this.velocityMax,
    this.velocityAvg,
  });

  String direction;
  double directionDegrees;
  double gustMax;
  double velocityMax;
  double velocityAvg;

  factory AfternoonWind.fromJson(Map<String, dynamic> json) => AfternoonWind(
        direction: json["direction"] != null ? json["direction"] : "",
        directionDegrees: json["direction_degrees"] != null ? json["direction_degrees"].toDouble() : 0.0,
        gustMax: json["gust_max"] != null ? json["gust_max"].toDouble() : 0.0,
        velocityMax: json["velocity_max"] != null ? json["velocity_max"].toDouble() : 0.0,
        velocityAvg: json["velocity_avg"] != null ? json["velocity_avg"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "direction_degrees": directionDegrees,
        "gust_max": gustMax,
        "velocity_max": velocityMax,
        "velocity_avg": velocityAvg,
      };
}
