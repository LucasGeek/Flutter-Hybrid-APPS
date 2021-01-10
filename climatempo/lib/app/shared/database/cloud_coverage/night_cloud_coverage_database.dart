import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'night_cloud_coverage_database.g.dart';

@DataClassName('NightCloudCoverageModel')
class NightCloudCoverageLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_cloud_coverage => integer().customConstraint("NULL REFERENCES cloud_coverage_locals(id)")();
  RealColumn get low => real().withDefault(Constant(0.0))();
  RealColumn get mid => real().withDefault(Constant(0.0))();
  RealColumn get high => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [NightCloudCoverageLocals])
class NightCloudCoverageLocalDAO extends DatabaseAccessor<MoorDatabase> with _$NightCloudCoverageLocalDAOMixin {
  NightCloudCoverageLocalDAO(MoorDatabase db) : super(db);

  Future insertNightCloudCoverage(NightCloudCoverageModel nightCloudCoverage) =>
      into(nightCloudCoverageLocals).insert(nightCloudCoverage);
  Future deleteNightCloudCoverage(NightCloudCoverageModel nightCloudCoverage) =>
      delete(nightCloudCoverageLocals).delete(nightCloudCoverage);
  Future deleteNightCloudCoverageByCloudCoverage(int id) async {
    var item = await (select(nightCloudCoverageLocals)..where((x) => x.id_cloud_coverage.equals(id))).getSingle();

    if (item != null) {
      await deleteNightCloudCoverage(item);
    }
  }

  Future<List<NightCloudCoverageModel>> getAll() => select(nightCloudCoverageLocals).get();
}
