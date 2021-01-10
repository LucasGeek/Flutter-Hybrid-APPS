import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'afternoon_temperature_database.g.dart';

@DataClassName('AfternoonTemperatureModel')
class AfternoonTemperatureLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_temperature => integer().customConstraint("NULL REFERENCES temperature_locals(id)")();
  RealColumn get min => real().withDefault(Constant(0.0))();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [AfternoonTemperatureLocals])
class AfternoonTemperatureLocalDAO extends DatabaseAccessor<MoorDatabase> with _$AfternoonTemperatureLocalDAOMixin {
  AfternoonTemperatureLocalDAO(MoorDatabase db) : super(db);

  Future insertAfternoonTemperature(AfternoonTemperatureModel afternoonTemperature) =>
      into(afternoonTemperatureLocals).insert(afternoonTemperature);
  Future deleteAfternoonTemperature(AfternoonTemperatureModel afternoonTemperature) =>
      delete(afternoonTemperatureLocals).delete(afternoonTemperature);
  Future deleteAfternoonTemperatureByTemperature(int id) async {
    var item = await (select(afternoonTemperatureLocals)..where((x) => x.id_temperature.equals(id))).getSingle();

    if (item != null) {
      await deleteAfternoonTemperature(item);
    }
  }

  Future<List<AfternoonTemperatureModel>> getAll() => select(afternoonTemperatureLocals).get();
}
