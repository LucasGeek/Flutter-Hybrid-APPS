import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'icon_database.g.dart';

@DataClassName('IconModel')
class IconLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_text_icon => integer().customConstraint("NULL REFERENCES text_icon_locals(id)")();
  TextColumn get dawn => text().withDefault(Constant(""))();
  TextColumn get morning => text().withDefault(Constant(""))();
  TextColumn get afternoon => text().withDefault(Constant(""))();
  TextColumn get night => text().withDefault(Constant(""))();
  TextColumn get day => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [IconLocals])
class IconLocalDAO extends DatabaseAccessor<MoorDatabase> with _$IconLocalDAOMixin {
  IconLocalDAO(MoorDatabase db) : super(db);

  Future insertIcon(IconModel icon) => into(iconLocals).insert(icon);
  Future deleteIcon(IconModel icon) => delete(iconLocals).delete(icon);
  Future deleteIconByTextIcon(int id) async {
    var item = await (select(iconLocals)..where((x) => x.id_text_icon.equals(id))).getSingle();

    if (item != null) {
      await deleteIcon(item);
    }
  }

  Future<List<IconModel>> getAll() => select(iconLocals).get();
}
