import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:hg_brasil/app/app_widget.dart';
import 'package:hg_brasil/app/modules/home/home_module.dart';
import 'package:hg_brasil/app/modules/splash/splash_module.dart';
import 'package:hg_brasil/app/shared/util/screen.dart';
import 'package:hg_brasil/app/shared/util/os.dart';
import 'app_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        //UTIL
        Bind((i) => OperationalSystem()),
        Bind((i) => Screen()),
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
