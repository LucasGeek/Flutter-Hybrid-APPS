import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'night_wind_database.g.dart';

@DataClassName('NightWindModel')
class NightWindLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_wind => integer().customConstraint("NULL REFERENCES wind_locals(id)")();
  RealColumn get direction_degrees => real().withDefault(Constant(0.0))();
  RealColumn get gust_max => real().withDefault(Constant(0.0))();
  RealColumn get velocity_max => real().withDefault(Constant(0.0))();
  RealColumn get velocity_avg => real().withDefault(Constant(0.0))();
  TextColumn get direction => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [NightWindLocals])
class NightWindLocalDAO extends DatabaseAccessor<MoorDatabase> with _$NightWindLocalDAOMixin {
  NightWindLocalDAO(MoorDatabase db) : super(db);

  Future insertNightWind(NightWindModel nightWind) => into(nightWindLocals).insert(nightWind);
  Future deleteNightWind(NightWindModel nightWind) => delete(nightWindLocals).delete(nightWind);
  Future deleteNightWindByWind(int id) async {
    var item = await (select(nightWindLocals)..where((x) => x.id_wind.equals(id))).getSingle();

    if (item != null) {
      await deleteNightWind(item);
    }
  }

  Future<List<NightWindModel>> getAll() => select(nightWindLocals).get();
}
