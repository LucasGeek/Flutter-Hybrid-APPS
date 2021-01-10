import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'wind_database.g.dart';

@DataClassName('WindModel')
class WindLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  //Intensidade minima do vento em km/h
  RealColumn get velocity_min => real().withDefault(Constant(0.0))();
  //Intensidade máxima do vento em km/h
  RealColumn get velocity_max => real().withDefault(Constant(0.0))();
  //Intensidade média do vento em km/h
  RealColumn get velocity_avg => real().withDefault(Constant(0.0))();
  //Rajada máxima do vento em km/h
  RealColumn get gust_max => real().withDefault(Constant(0.0))();
  //Direção do vento em graus
  RealColumn get direction_degrees => real().withDefault(Constant(0.0))();
  //Direção do vento
  TextColumn get direction => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [WindLocals])
class WindLocalDAO extends DatabaseAccessor<MoorDatabase> with _$WindLocalDAOMixin {
  WindLocalDAO(MoorDatabase db) : super(db);

  Future insertWind(WindModel wind) => into(windLocals).insert(wind);
  Future deleteWind(WindModel wind) => delete(windLocals).delete(wind);
  Future getWindByWeather(int id) => (select(windLocals)..where((tbl) => tbl.id_weather.equals(id))).getSingle();

  Future<List<WindModel>> getAll() => select(windLocals).get();
}
