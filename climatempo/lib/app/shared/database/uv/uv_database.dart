import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'uv_database.g.dart';

@DataClassName('UvModel')
class UvLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [UvLocals])
class UvLocalDAO extends DatabaseAccessor<MoorDatabase> with _$UvLocalDAOMixin {
  UvLocalDAO(MoorDatabase db) : super(db);

  Future insertUv(UvModel uv) => into(uvLocals).insert(uv);
  Future deleteUv(UvModel uv) => delete(uvLocals).delete(uv);
  Future<UvModel> getUvByWeather(int id) => (select(uvLocals)..where((tbl) => tbl.id_weather.equals(id))).getSingle();

  Future<List<UvModel>> getAll() => select(uvLocals).get();
}
