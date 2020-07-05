import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hg_brasil/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  debugPrint = (String message, {int wrapWidth}) => debugPrintSynchronously(
        "[${DateTime.now()}]: $message",
        wrapWidth: wrapWidth,
      );

  runApp(
    ModularApp(module: AppModule()),
  );
}
