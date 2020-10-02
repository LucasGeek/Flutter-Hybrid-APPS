import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  bool isExecute = false;

  @action
  void toggle() {
    isExecute = !isExecute;
  }

  @action
  Future<void> startService() async {
    toggle();

    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.messages");
      String data = await methodChannel.invokeMethod("startService");

      debugPrint("[${DateTime.now()}]: $data");
    }
  }

  @action
  Future<void> stopService() async {
    toggle();

    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.messages");
      String data = await methodChannel.invokeMethod("stopService");

      debugPrint("[${DateTime.now()}]: $data");
    }
  }
}
