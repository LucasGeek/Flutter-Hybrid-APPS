import 'package:moor_flutter/moor_flutter.dart';
import '_db/moor_database.dart';

part 'city_database.g.dart';

@DataClassName('CityModel')
class CityLocals extends Table {
  //ID da cidade.
  IntColumn get id => integer()();
  //Nome da cidade.
  TextColumn get name => text().withDefault(Constant(""))();
  //Estado da cidade
  TextColumn get state => text().withDefault(Constant(""))();
  //País da cidade
  TextColumn get country => text().withDefault(Constant(""))();
  //Data de insercão
  DateTimeColumn get data_insert => dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [CityLocals])
class CityLocalDAO extends DatabaseAccessor<MoorDatabase> with _$CityLocalDAOMixin {
  CityLocalDAO(MoorDatabase db) : super(db);

  Future insertCity(CityModel city) => into(cityLocals).insert(city);
  Future<CityModel> getCityById(int id) => (select(cityLocals)..where((x) => x.id.equals(id))).getSingle();
  Future<CityModel> getCityByName(String name, String state) =>
      (select(cityLocals)..where((x) => x.name.equals(name) & x.state.equals(state))).getSingle();
  Future deleteCity(CityModel city) => delete(cityLocals).delete(city);
}
