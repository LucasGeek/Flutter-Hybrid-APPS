import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'afternoon_wind_database.g.dart';

@DataClassName('AfternoonWindModel')
class AfternoonWindLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_wind => integer().customConstraint("NULL REFERENCES wind_locals(id)")();
  //
  RealColumn get direction_degrees => real().withDefault(Constant(0.0))();
  //
  RealColumn get gust_max => real().withDefault(Constant(0.0))();
  //
  RealColumn get velocity_max => real().withDefault(Constant(0.0))();
  //
  RealColumn get velocity_avg => real().withDefault(Constant(0.0))();
  //
  TextColumn get direction => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [AfternoonWindLocals])
class AfternoonWindLocalDAO extends DatabaseAccessor<MoorDatabase> with _$AfternoonWindLocalDAOMixin {
  AfternoonWindLocalDAO(MoorDatabase db) : super(db);

  Future insertAfternoonWind(AfternoonWindModel afternoonWind) => into(afternoonWindLocals).insert(afternoonWind);
  Future deleteAfternoonWind(AfternoonWindModel afternoonWind) => delete(afternoonWindLocals).delete(afternoonWind);
  Future deleteAfternoonWindByWind(int id) async {
    var item = await (select(afternoonWindLocals)..where((x) => x.id_wind.equals(id))).getSingle();

    if (item != null) {
      await deleteAfternoonWind(item);
    }
  }

  Future<List<AfternoonWindModel>> getAll() => select(afternoonWindLocals).get();
}
