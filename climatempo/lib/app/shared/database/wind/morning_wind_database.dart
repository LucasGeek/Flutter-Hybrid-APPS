import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'morning_wind_database.g.dart';

@DataClassName('MorningWindModel')
class MorningWindLocals extends Table {
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

@UseDao(tables: [MorningWindLocals])
class MorningWindLocalDAO extends DatabaseAccessor<MoorDatabase> with _$MorningWindLocalDAOMixin {
  MorningWindLocalDAO(MoorDatabase db) : super(db);

  Future insertMorningWind(MorningWindModel morningWind) => into(morningWindLocals).insert(morningWind);
  Future deleteMorningWind(MorningWindModel morningWind) => delete(morningWindLocals).delete(morningWind);
  Future deleteMorningWindByWind(int id) async {
    var item = await (select(morningWindLocals)..where((x) => x.id_wind.equals(id))).getSingle();

    if (item != null) {
      await deleteMorningWind(item);
    }
  }

  Future<List<MorningWindModel>> getAll() => select(morningWindLocals).get();
}
