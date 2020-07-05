import 'package:hg_brasil/app/shared/util/constant.dart';
import 'package:hg_brasil/app/shared/util/preference.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class OperationalSystem {
  bool _isAndroid = Platform.isAndroid;
  bool _isFuchsia = Platform.isFuchsia;
  bool _isIOS = Platform.isIOS;
  bool _isLinux = Platform.isLinux;
  bool _isMacOS = Platform.isMacOS;
  bool _isWindows = Platform.isWindows;
  bool _isWeb = kIsWeb;

  bool isMaterial = false;
  bool isCupertino = false;

  getStyle() async {
    await PreferenceApp.init();
    String styleOs = PreferenceApp.getString(ConstantApp.STYLE_APP);

    if (styleOs == ConstantApp.MATERIAL_APP) {
      isMaterial = true;
      isCupertino = false;
    } else if (styleOs == ConstantApp.CUPERTINO_APP) {
      isMaterial = false;
      isCupertino = true;
    } else {
      isMaterial =
          (_isAndroid || _isFuchsia || _isLinux || _isWindows || _isWeb);
      isCupertino = (_isIOS || _isMacOS);
    }
  }

  setStyle(String styleOs) async {
    await PreferenceApp.init();

    if (styleOs == ConstantApp.MATERIAL_APP) {
      isMaterial = true;
      isCupertino = false;

      PreferenceApp.setString(ConstantApp.STYLE_APP, ConstantApp.MATERIAL_APP);
    } else if (styleOs == ConstantApp.CUPERTINO_APP) {
      isMaterial = false;
      isCupertino = true;

      PreferenceApp.setString(ConstantApp.STYLE_APP, ConstantApp.CUPERTINO_APP);
    }
  }
}
