import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'rain_database.g.dart';

@DataClassName('RainModel')
class RainLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  //Probabilidade de chuva em porcentagem
  RealColumn get probability => real().withDefault(Constant(0.0))();
  //Precipitação em milímetro
  RealColumn get precipitation => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [RainLocals])
class RainLocalDAO extends DatabaseAccessor<MoorDatabase> with _$RainLocalDAOMixin {
  RainLocalDAO(MoorDatabase db) : super(db);

  Future insertRain(RainModel rain) => into(rainLocals).insert(rain);
  Future deleteRain(RainModel rain) => delete(rainLocals).delete(rain);
  Future<RainModel> getRainByWeather(id) => (select(rainLocals)..where((x) => x.id_weather.equals(id))).getSingle();

  Future<List<RainModel>> getAll() => select(rainLocals).get();
}
