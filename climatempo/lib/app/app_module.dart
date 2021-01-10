import 'package:climatempo_app/app/app_controller.dart';
import 'package:climatempo_app/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:climatempo_app/app/app_widget.dart';
import 'package:climatempo_app/app/modules/home/home_module.dart';

import 'shared/database/_db/moor_database.dart';
import 'shared/repository/city_repository.dart';
import 'shared/repository/localization_repository.dart';
import 'shared/repository/weather_repository.dart';
import 'shared/util/screen.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        //UTIL
        Bind((i) => Screen()),
        //REPOSITORY
        Bind((i) => LocalizationRepository()),
        Bind((i) => CityRepository(Modular.get<MoorDatabase>())),
        Bind((i) => WeatherRepository(Modular.get<MoorDatabase>())),
        //DATABASE
        Bind((i) => MoorDatabase()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: SplashModule()),
        Router("/home", module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
