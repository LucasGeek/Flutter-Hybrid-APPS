import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'thermal_sensation_database.g.dart';

@DataClassName('ThermalSensationModel')
class ThermalSensationLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  RealColumn get min => real().withDefault(Constant(0.0))();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [ThermalSensationLocals])
class ThermalSensationLocalDAO extends DatabaseAccessor<MoorDatabase> with _$ThermalSensationLocalDAOMixin {
  ThermalSensationLocalDAO(MoorDatabase db) : super(db);

  Future insertThermalSensation(ThermalSensationModel thermalSensation) =>
      into(thermalSensationLocals).insert(thermalSensation);
  Future deleteThermalSensation(ThermalSensationModel thermalSensation) =>
      delete(thermalSensationLocals).delete(thermalSensation);
  Future<ThermalSensationModel> getThermalSensationByWeather(int id) =>
      (select(thermalSensationLocals)..where((tbl) => tbl.id_weather.equals(id))).getSingle();

  Future<List<ThermalSensationModel>> getAll() => select(thermalSensationLocals).get();
}
