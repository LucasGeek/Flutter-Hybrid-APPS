import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'humidity_database.g.dart';

@DataClassName('HumidityModel')
class HumidityLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  //Umidade Relativa minima (%)
  RealColumn get min => real().withDefault(Constant(0.0))();
  //Umidade Relativa máxima (%)
  RealColumn get max => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [HumidityLocals])
class HumidityLocalDAO extends DatabaseAccessor<MoorDatabase> with _$HumidityLocalDAOMixin {
  HumidityLocalDAO(MoorDatabase db) : super(db);

  Future insertHumidity(HumidityModel humidity) => into(humidityLocals).insert(humidity);
  Future deleteHumidity(HumidityModel humidity) => delete(humidityLocals).delete(humidity);
  Future<List<HumidityModel>> getAll() => select(humidityLocals).get();
  Future<HumidityModel> getHumidityByWeather(int id) =>
      (select(humidityLocals)..where((x) => x.id_weather.equals(id))).getSingle();
}
