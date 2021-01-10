import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'dawn_humidity_database.g.dart';

@DataClassName('DawnHumidityModel')
class DawnHumidityLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_humidity => integer().customConstraint("NULL REFERENCES humidity_locals(id)")();
  //Umidade Relativa minima madrugada (%)
  RealColumn get min => real().withDefault(Constant(0.0))();
  //Umidade Relativa máxima madrugada (%)
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [DawnHumidityLocals])
class DawnHumidityLocalDAO extends DatabaseAccessor<MoorDatabase> with _$DawnHumidityLocalDAOMixin {
  DawnHumidityLocalDAO(MoorDatabase db) : super(db);

  Future<List<DawnHumidityModel>> getAll() => select(dawnHumidityLocals).get();
  Future insertDawnHumidity(DawnHumidityModel dawnHumidity) => into(dawnHumidityLocals).insert(dawnHumidity);
  Future deleteDawnHumidity(DawnHumidityModel dawnHumidity) => delete(dawnHumidityLocals).delete(dawnHumidity);
  Future deleteDawnHumidityByHumidity(int id) async {
    var item = await (select(dawnHumidityLocals)..where((x) => x.id_humidity.equals(id))).getSingle();

    if (item != null) {
      await deleteDawnHumidity(item);
    }
  }
}
