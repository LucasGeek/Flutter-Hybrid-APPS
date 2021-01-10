import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'morning_humidity_database.g.dart';

@DataClassName('MorningHumidityModel')
class MorningHumidityLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_humidity => integer().customConstraint("NULL REFERENCES humidity_locals(id)")();
  //Umidade Relativa minima manhã (%)
  RealColumn get min => real().withDefault(Constant(0.0))();
  //Umidade Relativa máxima manhã (%)
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [MorningHumidityLocals])
class MorningHumidityLocalDAO extends DatabaseAccessor<MoorDatabase> with _$MorningHumidityLocalDAOMixin {
  MorningHumidityLocalDAO(MoorDatabase db) : super(db);

  Future insertMorningHumidity(MorningHumidityModel morningHumidity) =>
      into(morningHumidityLocals).insert(morningHumidity);
  Future deleteMorningHumidity(MorningHumidityModel morningHumidity) =>
      delete(morningHumidityLocals).delete(morningHumidity);

  Future deleteMorningHumidityByHumidity(int id) async {
    var item = await (select(morningHumidityLocals)..where((x) => x.id_humidity.equals(id))).getSingle();

    if (item != null) {
      await deleteMorningHumidity(item);
    }
  }

  Future<List<MorningHumidityModel>> getAll() => select(morningHumidityLocals).get();
}
