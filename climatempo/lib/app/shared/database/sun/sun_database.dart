import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'sun_database.g.dart';

@DataClassName('SunModel')
class SunLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  TextColumn get sunrise => text().withDefault(Constant(""))();
  TextColumn get sunset => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [SunLocals])
class SunLocalDAO extends DatabaseAccessor<MoorDatabase> with _$SunLocalDAOMixin {
  SunLocalDAO(MoorDatabase db) : super(db);

  Future insertSun(SunModel sun) => into(sunLocals).insert(sun);
  Future deleteSun(SunModel sun) => delete(sunLocals).delete(sun);
  Future<SunModel> getSunByWeather(int id) =>
      (select(sunLocals)..where((tbl) => tbl.id_weather.equals(id))).getSingle();

  Future<List<SunModel>> getAll() => select(sunLocals).get();
}
