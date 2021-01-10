import 'package:climatempo_app/app/shared/util/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/util/colors.dart';
import '../../../shared/util/loading.dart';
import '../../../shared/util/screen.dart';
import '../splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  final screen = Modular.get<Screen>();

  Future _init() async {
    Future.delayed(Duration(seconds: 1)).then(
      (_) async {
        bool isGranted = await controller.verifyPermission();

        if (isGranted) {
          Modular.to.pushNamedAndRemoveUntil('/home/', (routes) => false);
        } else {
          Modular.to.pushNamedAndRemoveUntil('/permission', (routes) => false);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: screen.setHeight(90),
                  bottom: screen.setHeight(80),
                ),
                child: Image.asset(
                  Assets.logo,
                  height: screen.setHeight(500),
                  fit: BoxFit.cover,
                ),
              ),
              ThreeSizeDot(
                color_1: AppColors.primary,
                color_2: AppColors.primary,
                color_3: AppColors.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
