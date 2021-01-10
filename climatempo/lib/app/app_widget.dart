import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'shared/util/colors.dart';
import 'dart:io';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(AppColors.primaryInt, {
      50: AppColors.primary.withOpacity(1),
      100: AppColors.primary.withOpacity(1),
      200: AppColors.primary.withOpacity(1),
      300: AppColors.primary.withOpacity(1),
      400: AppColors.primary.withOpacity(1),
      500: AppColors.primary.withOpacity(1),
      600: AppColors.primary.withOpacity(1),
      700: AppColors.primary.withOpacity(1),
      800: AppColors.primary.withOpacity(1),
      900: AppColors.primary.withOpacity(1),
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Clima Tempo',
      theme: ThemeData(
        primarySwatch: colorCustom,
        cursorColor: colorCustom,
        accentColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        brightness: Platform.isIOS ? Brightness.dark : Brightness.light,
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      builder: BotToastInit(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("pt"),
      ],
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
    );
  }
}
