import 'package:flutter_modular/flutter_modular.dart';
import 'package:hg_brasil/app/shared/util/os.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  _AppControllerBase() {
    style();
  }

  @observable
  bool isMaterial = true;

  @observable
  bool isCupertino = false;

  @action
  Future<void> style() async {
    OperationalSystem os = Modular.get<OperationalSystem>();
    await os.getStyle();

    isMaterial = os.isMaterial;
    isCupertino = os.isCupertino;
  }
}
