import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'night_temperature_database.g.dart';

@DataClassName('NightTemperatureModel')
class NightTemperatureLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_temperature => integer().customConstraint("NULL REFERENCES temperature_locals(id)")();
  RealColumn get min => real().withDefault(Constant(0.0))();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [NightTemperatureLocals])
class NightTemperatureLocalDAO extends DatabaseAccessor<MoorDatabase> with _$NightTemperatureLocalDAOMixin {
  NightTemperatureLocalDAO(MoorDatabase db) : super(db);

  Future insertNightTemperature(NightTemperatureModel nightTemperature) =>
      into(nightTemperatureLocals).insert(nightTemperature);
  Future deleteNightTemperature(NightTemperatureModel nightTemperature) =>
      delete(nightTemperatureLocals).delete(nightTemperature);
  Future deleteNightTemperatureByTemperature(int id) async {
    var item = await (select(nightTemperatureLocals)..where((x) => x.id_temperature.equals(id))).getSingle();

    if (item != null) {
      await deleteNightTemperature(item);
    }
  }

  Future<List<NightTemperatureModel>> getAll() => select(nightTemperatureLocals).get();
}
