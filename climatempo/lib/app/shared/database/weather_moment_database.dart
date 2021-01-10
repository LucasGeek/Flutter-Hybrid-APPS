import 'package:moor_flutter/moor_flutter.dart';
import '_db/moor_database.dart';

part 'weather_moment_database.g.dart';

@DataClassName('WeatherMomentModel')
class WeatherMomentLocals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get id_city => integer()();
  RealColumn get temperature => real().withDefault(Constant(0.0))();
  RealColumn get wind_velocity => real().withDefault(Constant(0.0))();
  RealColumn get humidity => real().withDefault(Constant(0.0))();
  RealColumn get pressure => real().withDefault(Constant(0.0))();
  RealColumn get sensation => real().withDefault(Constant(0.0))();
  TextColumn get wind_direction => text().withDefault(Constant(""))();
  TextColumn get condition => text().withDefault(Constant(""))();
  TextColumn get icon => text().withDefault(Constant(""))();
  DateTimeColumn get date_insert => dateTime()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [WeatherMomentLocals])
class WeatherMomentLocalDAO extends DatabaseAccessor<MoorDatabase> with _$WeatherMomentLocalDAOMixin {
  WeatherMomentLocalDAO(MoorDatabase db) : super(db);

  Future deleteWeatherMoment(WeatherMomentModel weather) => delete(weatherMomentLocals).delete(weather);
  Future<WeatherMomentModel> getWeatherMomentModel(int cityId, DateTime data) => (select(weatherMomentLocals)
        ..where(
          (tbl) =>
              tbl.id_city.equals(cityId) &
              (tbl.date_insert.day.equals(data.day) &
                  tbl.date_insert.month.equals(data.month) &
                  tbl.date_insert.year.equals(data.year)),
        ))
      .getSingle();
  Future insertWeatherMoment(WeatherMomentModel weather) async {
    var moments = await (select(weatherMomentLocals)
          ..where(
            (tbl) =>
                tbl.id_city.equals(weather.id_city) &
                (tbl.date_insert.day.equals(weather.date_insert.day) &
                    tbl.date_insert.month.equals(weather.date_insert.month) &
                    tbl.date_insert.year.equals(weather.date_insert.year)),
          ))
        .get();

    moments.forEach((element) async {
      await deleteWeatherMoment(element);
    });

    into(weatherMomentLocals).insert(weather);
  }
}
