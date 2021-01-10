import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'morning_temperature_database.g.dart';

@DataClassName('MorningTemperatureModel')
class MorningTemperatureLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_temperature => integer().customConstraint("NULL REFERENCES temperature_locals(id)")();
  RealColumn get min => real().withDefault(Constant(0.0))();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [MorningTemperatureLocals])
class MorningTemperatureLocalDAO extends DatabaseAccessor<MoorDatabase> with _$MorningTemperatureLocalDAOMixin {
  MorningTemperatureLocalDAO(MoorDatabase db) : super(db);

  Future insertMorningTemperature(MorningTemperatureModel morningTemperature) =>
      into(morningTemperatureLocals).insert(morningTemperature);
  Future deleteMorningTemperature(MorningTemperatureModel morningTemperature) =>
      delete(morningTemperatureLocals).delete(morningTemperature);
  Future deleteMorningTemperatureByTemperature(int id) async {
    var item = await (select(morningTemperatureLocals)..where((x) => x.id_temperature.equals(id))).getSingle();

    if (item != null) {
      await deleteMorningTemperature(item);
    }
  }

  Future<List<MorningTemperatureModel>> getAll() => select(morningTemperatureLocals).get();
}
