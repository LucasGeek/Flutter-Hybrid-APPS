import 'package:climatempo_app/app/shared/database/weather_moment_database.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../city_database.dart';
import '../weather_database.dart';

import '../humidity/dawn_humidity_database.dart';
import '../humidity/humidity_database.dart';
import '../humidity/afternoon_humidity_database.dart';
import '../humidity/morning_humidity_database.dart';
import '../humidity/night_humidity_database.dart';

import '../rain/rain_database.dart';

import '../wind/wind_database.dart';
import '../wind/dawn_wind_database.dart';
import '../wind/morning_wind_database.dart';
import '../wind/afternoon_wind_database.dart';
import '../wind/night_wind_database.dart';

import '../uv/uv_database.dart';

import '../thermal_sensation/thermal_sensation_database.dart';

import '../text_icon/text_icon_database.dart';
import '../text_icon/text_database.dart';
import '../text_icon/icon_database.dart';
import '../text_icon/phrase_database.dart';

import '../temperature/dawn_temperature_database.dart';
import '../temperature/temperature_database.dart';
import '../temperature/afternoon_temperature_database.dart';
import '../temperature/morning_temperature_database.dart';
import '../temperature/night_temperature_database.dart';

import '../cloud_coverage/cloud_coverage_database.dart';
import '../cloud_coverage/dawn_cloud_coverage_database.dart';
import '../cloud_coverage/afternoon_cloud_coverage_database.dart';
import '../cloud_coverage/morning_cloud_coverage_database.dart';
import '../cloud_coverage/night_cloud_coverage_database.dart';

import '../sun/sun_database.dart';

// Moor works by source gen. This file will all the generated code.
part 'moor_database.g.dart';

// This annotation tells the code generator which tables this DB works with
@UseMoor(tables: [
  CityLocals,
  WeatherLocals,
  WeatherMomentLocals,
  HumidityLocals,
  DawnHumidityLocals,
  AfternoonHumidityLocals,
  MorningHumidityLocals,
  NightHumidityLocals,
  RainLocals,
  WindLocals,
  DawnWindLocals,
  MorningWindLocals,
  AfternoonWindLocals,
  NightWindLocals,
  UvLocals,
  ThermalSensationLocals,
  TextIconLocals,
  TextLocals,
  IconLocals,
  PhraseLocals,
  TemperatureLocals,
  DawnTemperatureLocals,
  AfternoonTemperatureLocals,
  MorningTemperatureLocals,
  NightTemperatureLocals,
  CloudCoverageLocals,
  AfternoonCloudCoverageLocals,
  DawnCloudCoverageLocals,
  MorningCloudCoverageLocals,
  NightCloudCoverageLocals,
  SunLocals,
], daos: [
  CityLocalDAO,
  WeatherLocalDAO,
  WeatherMomentLocalDAO,
  HumidityLocalDAO,
  DawnHumidityLocalDAO,
  AfternoonHumidityLocalDAO,
  MorningHumidityLocalDAO,
  NightHumidityLocalDAO,
  RainLocalDAO,
  WindLocalDAO,
  DawnWindLocalDAO,
  MorningWindLocalDAO,
  AfternoonWindLocalDAO,
  NightWindLocalDAO,
  UvLocalDAO,
  ThermalSensationLocalDAO,
  TextIconLocalDAO,
  TextLocalDAO,
  IconLocalDAO,
  PhraseLocalDAO,
  TemperatureLocalDAO,
  DawnTemperatureLocalDAO,
  AfternoonTemperatureLocalDAO,
  MorningTemperatureLocalDAO,
  NightTemperatureLocalDAO,
  CloudCoverageLocalDAO,
  AfternoonCloudCoverageLocalDAO,
  DawnCloudCoverageLocalDAO,
  MorningCloudCoverageLocalDAO,
  NightCloudCoverageLocalDAO,
  SunLocalDAO,
])
// _$MoorDatabase is the name of the generated class
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'climatempo_db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });

  Future<CityWeather> cityWeather(int cityId) async {
    final dateNow = DateTime.now();
    final _city = alias(cityLocals, 'c');
    final _weather = alias(weatherLocals, 'w');

    final rows = await select(_city).join([
      innerJoin(_weather, _weather.id_city.equalsExp(_city.id)),
    ]).get();

    final result = rows
        .map(
          (resultRow) {
            return CityWeather(
              city: resultRow.readTable(_city),
              weather: resultRow.readTable(_weather),
            );
          },
        )
        .where(
          (e) =>
              (e.city.data_insert.day == dateNow.day &&
                  e.city.data_insert.month == dateNow.month &&
                  e.city.data_insert.year == dateNow.year) &&
              e.city.id == cityId &&
              e.weather != null,
        )
        .toList();

    return result.length != 0 ? result.first : null;
  }
}

class CityWeather {
  CityModel city;
  WeatherModel weather;

  CityWeather({this.city, this.weather});
}
