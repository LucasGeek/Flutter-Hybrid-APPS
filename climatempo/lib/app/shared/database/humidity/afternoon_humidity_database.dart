import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'afternoon_humidity_database.g.dart';

@DataClassName('AfternoonHumidityModel')
class AfternoonHumidityLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_humidity => integer().customConstraint("NULL REFERENCES humidity_locals(id)")();
  //Umidade Relativa minima tarde (%)
  RealColumn get min => real().withDefault(Constant(0.0))();
  //Umidade Relativa máxima tarde (%)
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [AfternoonHumidityLocals])
class AfternoonHumidityLocalDAO extends DatabaseAccessor<MoorDatabase> with _$AfternoonHumidityLocalDAOMixin {
  AfternoonHumidityLocalDAO(MoorDatabase db) : super(db);

  Future insertAfternoonHumidity(AfternoonHumidityModel afternoonHumidity) =>
      into(afternoonHumidityLocals).insert(afternoonHumidity);
  Future deleteAfternoonHumidity(AfternoonHumidityModel afternoonHumidity) =>
      delete(afternoonHumidityLocals).delete(afternoonHumidity);

  Future deleteAfternoonHumidityByHumidity(int id) async {
    var item = await (select(afternoonHumidityLocals)..where((x) => x.id_humidity.equals(id))).getSingle();

    if (item != null) {
      await deleteAfternoonHumidity(item);
    }
  }

  Future<List<AfternoonHumidityModel>> getAll() => select(afternoonHumidityLocals).get();
}
