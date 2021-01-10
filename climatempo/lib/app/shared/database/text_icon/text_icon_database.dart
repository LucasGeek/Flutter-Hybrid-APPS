import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'text_icon_database.g.dart';

@DataClassName('TextIconModel')
class TextIconLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [TextIconLocals])
class TextIconLocalDAO extends DatabaseAccessor<MoorDatabase> with _$TextIconLocalDAOMixin {
  TextIconLocalDAO(MoorDatabase db) : super(db);

  Future insertTextIcon(TextIconModel textIcon) => into(textIconLocals).insert(textIcon);
  Future deleteTextIcon(TextIconModel textIcon) => delete(textIconLocals).delete(textIcon);
  Future<TextIconModel> getTextIconByWeather(int id) =>
      (select(textIconLocals)..where((tbl) => tbl.id_weather.equals(id))).getSingle();

  Future<List<TextIconModel>> getAll() => select(textIconLocals).get();
}
