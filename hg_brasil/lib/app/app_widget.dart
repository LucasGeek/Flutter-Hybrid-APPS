import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hg_brasil/app/shared/util/preference.dart';

import 'app_controller.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  AppController _appController;

  @override
  void initState() {
    PreferenceApp.init();

    _appController = Modular.get<AppController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Observer(
      builder: (_) {
        if (_appController.isCupertino) {
          return CupertinoApp(
            navigatorKey: Modular.navigatorKey,
            title: 'Flutter Slidy',
            theme: CupertinoThemeData(
              primaryColor: Colors.blue,
            ),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
          );
        } else {
          return MaterialApp(
            navigatorKey: Modular.navigatorKey,
            title: 'Flutter Slidy',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
          );
        }
      },
    );
  }
}
