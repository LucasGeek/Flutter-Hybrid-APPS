import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hg_brasil/app/shared/util/color.dart';
import 'package:hg_brasil/app/shared/util/screen.dart';
import 'weather_cupertino_tab_controller.dart';

class WeatherCupertinoTabPage extends StatefulWidget {
  final String title;
  const WeatherCupertinoTabPage({Key key, this.title = "Clima"}) : super(key: key);

  @override
  _WeatherCupertinoTabPageState createState() => _WeatherCupertinoTabPageState();
}

class _WeatherCupertinoTabPageState extends ModularState<WeatherCupertinoTabPage, WeatherCupertinoTabController> {
  var screen = Modular.get<Screen>();
  var selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: GestureDetector(
          onTap: () {
            setState(() => selectedTab = 1);
          },
          child: Icon(
            CupertinoIcons.add,
          ),
        ),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              width: screen.screenWidthDp,
              child: CupertinoSegmentedControl(
                children: const <int, Widget>{
                  0: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Minha localização',
                    ),
                  ),
                  1: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      '+',
                    ),
                  ),
                },
                groupValue: selectedTab,
                onValueChanged: (value) {
                  setState(() => selectedTab = value);
                },
              ),
            ),
            Expanded(
              child: Container(
                color: selectedTab == 0 ? AppColors.redColor : AppColors.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
