import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'phrase_database.g.dart';

@DataClassName('PhraseModel')
class PhraseLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_text => integer().customConstraint("NULL REFERENCES text_locals(id)")();
  TextColumn get reduced => text().withDefault(Constant(""))();
  TextColumn get morning => text().withDefault(Constant(""))();
  TextColumn get afternoon => text().withDefault(Constant(""))();
  TextColumn get night => text().withDefault(Constant(""))();
  TextColumn get dawn => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [PhraseLocals])
class PhraseLocalDAO extends DatabaseAccessor<MoorDatabase> with _$PhraseLocalDAOMixin {
  PhraseLocalDAO(MoorDatabase db) : super(db);

  Future insertPharase(PhraseModel phrase) => into(phraseLocals).insert(phrase);
  Future deletePharase(PhraseModel phrase) => delete(phraseLocals).delete(phrase);
  Future deletePhraseByText(int id) async {
    var item = await (select(phraseLocals)..where((x) => x.id_text.equals(id))).getSingle();

    if (item != null) {
      await deletePharase(item);
    }
  }

  Future<List<PhraseModel>> getAll() => select(phraseLocals).get();
}
