import 'package:moor_flutter/moor_flutter.dart';
import '_db/moor_database.dart';

part 'weather_database.g.dart';

@DataClassName('WeatherModel')
class WeatherLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  //Foreign Key
  IntColumn get id_city => integer().customConstraint("NULL REFERENCES city_locals(id)")();
  //Data clima tempo
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [WeatherLocals])
class WeatherLocalDAO extends DatabaseAccessor<MoorDatabase> with _$WeatherLocalDAOMixin {
  WeatherLocalDAO(MoorDatabase db) : super(db);

  Future insertWeather(WeatherModel weather) => into(weatherLocals).insert(weather);
  Future deleteWeather(WeatherModel weather) => delete(weatherLocals).delete(weather);
  Future<List<WeatherModel>> getWeatherByCity(int id) =>
      (select(weatherLocals)..where((x) => x.id_city.equals(id))).get();
}
