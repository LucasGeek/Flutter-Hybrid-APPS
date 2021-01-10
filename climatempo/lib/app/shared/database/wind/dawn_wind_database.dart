import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'dawn_wind_database.g.dart';

@DataClassName('DawnWindModel')
class DawnWindLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_wind => integer().customConstraint("NULL REFERENCES wind_locals(id)")();
  //Direção do vento madrugada em graus
  RealColumn get direction_degrees => real().withDefault(Constant(0.0))();
  //Rajada máxima do vento madrugada em km/h
  RealColumn get gust_max => real().withDefault(Constant(0.0))();
  //Intensidade máxima do vento madrugada em km/h
  RealColumn get velocity_max => real().withDefault(Constant(0.0))();
  //Intensidade media do vento madrugada em km/h
  RealColumn get velocity_avg => real().withDefault(Constant(0.0))();
  //Direção do vento madrugada
  TextColumn get direction => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [DawnWindLocals])
class DawnWindLocalDAO extends DatabaseAccessor<MoorDatabase> with _$DawnWindLocalDAOMixin {
  DawnWindLocalDAO(MoorDatabase db) : super(db);

  Future insertDawnWind(DawnWindModel dawnWind) => into(dawnWindLocals).insert(dawnWind);
  Future deleteDawnWind(DawnWindModel dawnWind) => delete(dawnWindLocals).delete(dawnWind);
  Future deleteDawnWindByWind(int id) async {
    var item = await (select(dawnWindLocals)..where((x) => x.id_wind.equals(id))).getSingle();

    if (item != null) {
      await deleteDawnWind(item);
    }
  }

  Future<List<DawnWindModel>> getAll() => select(dawnWindLocals).get();
}
