import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'dawn_temperature_database.g.dart';

@DataClassName('DawnTemperatureModel')
class DawnTemperatureLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_temperature => integer().customConstraint("NULL REFERENCES temperature_locals(id)")();
  RealColumn get min => real().withDefault(Constant(0.0))();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [DawnTemperatureLocals])
class DawnTemperatureLocalDAO extends DatabaseAccessor<MoorDatabase> with _$DawnTemperatureLocalDAOMixin {
  DawnTemperatureLocalDAO(MoorDatabase db) : super(db);

  Future insertDawnTemperature(DawnTemperatureModel dawnTemperature) =>
      into(dawnTemperatureLocals).insert(dawnTemperature);
  Future deleteDawnTemperature(DawnTemperatureModel dawnTemperature) =>
      delete(dawnTemperatureLocals).delete(dawnTemperature);
  Future deleteDawnTemperatureByTemperature(int id) async {
    var item = await (select(dawnTemperatureLocals)..where((x) => x.id_temperature.equals(id))).getSingle();

    if (item != null) {
      await deleteDawnTemperature(item);
    }
  }

  Future<List<DawnTemperatureModel>> getAll() => select(dawnTemperatureLocals).get();
}
