import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'night_humidity_database.g.dart';

@DataClassName('NightHumidityModel')
class NightHumidityLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_humidity => integer().customConstraint("NULL REFERENCES humidity_locals(id)")();
  //Umidade Relativa minima noite (%)
  RealColumn get min => real().withDefault(Constant(0.0))();
  //Umidade Relativa máxima noite (%)
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [NightHumidityLocals])
class NightHumidityLocalDAO extends DatabaseAccessor<MoorDatabase> with _$NightHumidityLocalDAOMixin {
  NightHumidityLocalDAO(MoorDatabase db) : super(db);

  Future insertNightHumidity(NightHumidityModel nightHumidity) => into(nightHumidityLocals).insert(nightHumidity);
  Future deleteNightHumidity(NightHumidityModel nightHumidity) => delete(nightHumidityLocals).delete(nightHumidity);

  Future deleteNightHumidityByHumidity(int id) async {
    var item = await (select(nightHumidityLocals)..where((x) => x.id_humidity.equals(id))).getSingle();

    if (item != null) {
      await deleteNightHumidity(item);
    }
  }

  Future<List<NightHumidityModel>> getAll() => select(nightHumidityLocals).get();
}
