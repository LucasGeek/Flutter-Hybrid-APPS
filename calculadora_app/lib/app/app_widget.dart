import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

const basePrimaryColorIOS = const Color(0xFF000000);

const basePrimaryColorAndroid = const Color(0xFF000000);
const baseAccentColorAndroid = const Color(0xFFF39C12);

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Calculadora IOS',
            debugShowCheckedModeBanner: false,
            navigatorKey: Modular.navigatorKey,
            theme: CupertinoThemeData(
              brightness: Brightness.dark,
              primaryColor: basePrimaryColorIOS,
              scaffoldBackgroundColor: basePrimaryColorIOS,
            ),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
          )
        : MaterialApp(
            title: 'Calculadora Android',
            debugShowCheckedModeBanner: false,
            navigatorKey: Modular.navigatorKey,
            theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: MaterialColor(
                0xFF000000,
                <int, Color>{
                  50: basePrimaryColorAndroid,
                  100: basePrimaryColorAndroid,
                  200: basePrimaryColorAndroid,
                  300: basePrimaryColorAndroid,
                  400: basePrimaryColorAndroid,
                  500: basePrimaryColorAndroid,
                  600: basePrimaryColorAndroid,
                  700: basePrimaryColorAndroid,
                  800: basePrimaryColorAndroid,
                  900: basePrimaryColorAndroid,
                },
              ),
              primaryColor: basePrimaryColorAndroid,
              accentColor: baseAccentColorAndroid,
            ),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
          );
  }
}
