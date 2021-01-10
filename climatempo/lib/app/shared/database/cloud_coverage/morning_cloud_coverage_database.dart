import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'morning_cloud_coverage_database.g.dart';

@DataClassName('MorningCloudCoverageModel')
class MorningCloudCoverageLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_cloud_coverage => integer().customConstraint("NULL REFERENCES cloud_coverage_locals(id)")();
  RealColumn get low => real().withDefault(Constant(0.0))();
  RealColumn get mid => real().withDefault(Constant(0.0))();
  RealColumn get high => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [MorningCloudCoverageLocals])
class MorningCloudCoverageLocalDAO extends DatabaseAccessor<MoorDatabase> with _$MorningCloudCoverageLocalDAOMixin {
  MorningCloudCoverageLocalDAO(MoorDatabase db) : super(db);

  Future insertMorningCloudCoverage(MorningCloudCoverageModel morningCloudCoverage) =>
      into(morningCloudCoverageLocals).insert(morningCloudCoverage);
  Future deleteMorningCloudCoverage(MorningCloudCoverageModel morningCloudCoverage) =>
      delete(morningCloudCoverageLocals).delete(morningCloudCoverage);
  Future deleteMorningCloudCoverageByCloudCoverage(int id) async {
    var item = await (select(morningCloudCoverageLocals)..where((x) => x.id_cloud_coverage.equals(id))).getSingle();

    if (item != null) {
      await deleteMorningCloudCoverage(item);
    }
  }

  Future<List<MorningCloudCoverageModel>> getAll() => select(morningCloudCoverageLocals).get();
}
