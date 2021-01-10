import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'temperature_database.g.dart';

@DataClassName('TemperatureModel')
class TemperatureLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  RealColumn get min => real().withDefault(Constant(0.0))();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [TemperatureLocals])
class TemperatureLocalDAO extends DatabaseAccessor<MoorDatabase> with _$TemperatureLocalDAOMixin {
  TemperatureLocalDAO(MoorDatabase db) : super(db);

  Future insertTemperature(TemperatureModel temperature) => into(temperatureLocals).insert(temperature);
  Future deleteTemperature(TemperatureModel temperature) => delete(temperatureLocals).delete(temperature);
  Future<TemperatureModel> getTemperatureByWeather(int id) =>
      (select(temperatureLocals)..where((x) => x.id_weather.equals(id))).getSingle();

  Future<List<TemperatureModel>> getAll() => select(temperatureLocals).get();
}
