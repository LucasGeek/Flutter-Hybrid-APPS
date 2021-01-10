import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'afternoon_cloud_coverage_database.g.dart';

@DataClassName('AfternoonCloudCoverageModel')
class AfternoonCloudCoverageLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_cloud_coverage => integer().customConstraint("NULL REFERENCES cloud_coverage_locals(id)")();
  RealColumn get low => real().withDefault(Constant(0.0))();
  RealColumn get mid => real().withDefault(Constant(0.0))();
  RealColumn get high => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [AfternoonCloudCoverageLocals])
class AfternoonCloudCoverageLocalDAO extends DatabaseAccessor<MoorDatabase> with _$AfternoonCloudCoverageLocalDAOMixin {
  AfternoonCloudCoverageLocalDAO(MoorDatabase db) : super(db);

  Future insertAfternoonCloudCoverage(AfternoonCloudCoverageModel afternoonCloudCoverage) =>
      into(afternoonCloudCoverageLocals).insert(afternoonCloudCoverage);
  Future deleteAfternoonCloudCoverage(AfternoonCloudCoverageModel afternoonCloudCoverage) =>
      delete(afternoonCloudCoverageLocals).delete(afternoonCloudCoverage);
  Future deleteAfternoonCloudCoverageByCloudCoverage(int id) async {
    var item = await (select(afternoonCloudCoverageLocals)..where((x) => x.id_cloud_coverage.equals(id))).getSingle();

    if (item != null) {
      await deleteAfternoonCloudCoverage(item);
    }
  }

  Future<List<AfternoonCloudCoverageModel>> getAll() => select(afternoonCloudCoverageLocals).get();
}
