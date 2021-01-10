import 'package:moor_flutter/moor_flutter.dart';
import '../_db/moor_database.dart';

part 'cloud_coverage_database.g.dart';

@DataClassName('CloudCoverageModel')
class CloudCoverageLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_weather => integer().customConstraint("NULL REFERENCES weather_locals(id)")();
  RealColumn get low => real().withDefault(Constant(0.0))();
  RealColumn get mid => real().withDefault(Constant(0.0))();
  RealColumn get high => real().withDefault(Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [CloudCoverageLocals])
class CloudCoverageLocalDAO extends DatabaseAccessor<MoorDatabase> with _$CloudCoverageLocalDAOMixin {
  CloudCoverageLocalDAO(MoorDatabase db) : super(db);

  Future insertCloudCoverage(CloudCoverageModel cloudCoverge) => into(cloudCoverageLocals).insert(cloudCoverge);
  Future deleteCloudCoverage(CloudCoverageModel cloudCoverge) => delete(cloudCoverageLocals).delete(cloudCoverge);
  Future getCloudCoverageByWeather(int id) =>
      (select(cloudCoverageLocals)..where((tbl) => tbl.id_weather.equals(id))).getSingle();

  Future<List<CloudCoverageModel>> getAll() => select(cloudCoverageLocals).get();
}
