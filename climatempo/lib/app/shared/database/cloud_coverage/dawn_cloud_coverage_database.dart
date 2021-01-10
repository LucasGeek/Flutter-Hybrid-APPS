import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'dawn_cloud_coverage_database.g.dart';

@DataClassName('DawnCloudCoverageModel')
class DawnCloudCoverageLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_cloud_coverage => integer().customConstraint("NULL REFERENCES cloud_coverage_locals(id)")();
  RealColumn get low => real().withDefault(Constant(0.0))();
  RealColumn get mid => real().withDefault(Constant(0.0))();
  RealColumn get high => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [DawnCloudCoverageLocals])
class DawnCloudCoverageLocalDAO extends DatabaseAccessor<MoorDatabase> with _$DawnCloudCoverageLocalDAOMixin {
  DawnCloudCoverageLocalDAO(MoorDatabase db) : super(db);

  Future insertDawnCloudCoverage(DawnCloudCoverageModel dawnCloudCoverage) =>
      into(dawnCloudCoverageLocals).insert(dawnCloudCoverage);
  Future deleteDawnCloudCoverage(DawnCloudCoverageModel dawnCloudCoverage) =>
      delete(dawnCloudCoverageLocals).delete(dawnCloudCoverage);
  Future deleteDawnCloudCoverageByCloudCoverage(int id) async {
    var item = await (select(dawnCloudCoverageLocals)..where((x) => x.id_cloud_coverage.equals(id))).getSingle();

    if (item != null) {
      await deleteDawnCloudCoverage(item);
    }
  }

  Future<List<DawnCloudCoverageModel>> getAll() => select(dawnCloudCoverageLocals).get();
}
