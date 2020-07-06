import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hg_brasil/app/shared/util/color.dart';
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
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    final MaterialColor colorCustom = MaterialColor(AppColors.primaryInt, {
      50: AppColors.primary.withOpacity(.1),
      100: AppColors.primary.withOpacity(.2),
      200: AppColors.primary.withOpacity(.3),
      300: AppColors.primary.withOpacity(.4),
      400: AppColors.primary.withOpacity(.5),
      500: AppColors.primary.withOpacity(.6),
      600: AppColors.primary.withOpacity(.7),
      700: AppColors.primary.withOpacity(.8),
      800: AppColors.primary.withOpacity(.9),
      900: AppColors.primary.withOpacity(1),
    });

    return Observer(
      builder: (_) {
        if (_appController.isCupertino && !_appController.isMaterial) {
          return CupertinoApp(
            navigatorKey: Modular.navigatorKey,
            title: 'HG Brasil',
            theme: CupertinoThemeData(
              primaryColor: AppColors.primary,
              primaryContrastingColor: AppColors.primary,
              scaffoldBackgroundColor: AppColors.backgroundLight,
              barBackgroundColor: AppColors.backgroundLight,
            ),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale("pt"),
            ],
          );
        }

        return MaterialApp(
          navigatorKey: Modular.navigatorKey,
          title: 'HG Brasil',
          theme: ThemeData(
            primarySwatch: colorCustom,
            cursorColor: colorCustom,
            accentColor: AppColors.secondary,
            scaffoldBackgroundColor: AppColors.backgroundLight,
          ),
          initialRoute: '/',
          onGenerateRoute: Modular.generateRoute,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("pt"),
          ],
        );
      },
    );
  }
}
