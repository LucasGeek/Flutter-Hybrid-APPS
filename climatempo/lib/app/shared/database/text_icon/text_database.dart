import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'text_database.g.dart';

@DataClassName('TextModel')
class TextLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_text_icon => integer().customConstraint("NULL REFERENCES text_icon_locals(id)")();
  TextColumn get pt => text().withDefault(Constant(""))();
  TextColumn get en => text().withDefault(Constant(""))();
  TextColumn get es => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [TextLocals])
class TextLocalDAO extends DatabaseAccessor<MoorDatabase> with _$TextLocalDAOMixin {
  TextLocalDAO(MoorDatabase db) : super(db);

  Future insertText(TextModel text) => into(textLocals).insert(text);
  Future deleteText(TextModel text) => delete(textLocals).delete(text);
  Future<TextModel> getTextByTextIcon(int id) =>
      (select(textLocals)..where((tbl) => tbl.id_text_icon.equals(id))).getSingle();

  Future<List<TextModel>> getAll() => select(textLocals).get();
}
