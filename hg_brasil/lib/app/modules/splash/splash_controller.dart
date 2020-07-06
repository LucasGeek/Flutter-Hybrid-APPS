import 'package:flutter_modular/flutter_modular.dart';
import 'package:hg_brasil/app/app_controller.dart';
import 'package:hg_brasil/app/shared/helper/permission_helper.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final _permission = PermissionHelper();

  final appController = Modular.get<AppController>();

  Future<bool> enablePermission() async {
    return await _permission.enablePermission();
  }

  Future<bool> verifyPermission() async {
    return await _permission.verifyPermission();
  }
}
