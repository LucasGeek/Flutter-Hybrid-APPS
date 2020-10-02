import 'package:mobx/mobx.dart';

part 'weather_cupertino_tab_controller.g.dart';

class WeatherCupertinoTabController = _WeatherCupertinoTabControllerBase
    with _$WeatherCupertinoTabController;

abstract class _WeatherCupertinoTabControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
