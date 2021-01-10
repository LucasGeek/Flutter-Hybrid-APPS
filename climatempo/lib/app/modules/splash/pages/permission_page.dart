import 'package:climatempo_app/app/shared/util/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:climatempo_app/app/shared/util/screen.dart';
import 'package:climatempo_app/app/shared/util/colors.dart';

import '../../../shared/util/button.dart';
import '../splash_controller.dart';

class PermissionPage extends StatefulWidget {
  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends ModularState<PermissionPage, SplashController> {
  final screen = Modular.get<Screen>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: screen.setHeight(90),
            left: screen.setWidth(40),
            right: screen.setWidth(40),
            bottom: screen.setHeight(20),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Antes de qualquer coisa conceda as permissões!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87.withOpacity(.8),
                          fontSize: screen.setSp(60),
                          fontWeight: FontWeight.w600,
                          //fontFamily: FontFamily.bRegular,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Permissões necessarias para que o app funcione com qualidade!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87.withOpacity(.8),
                          fontSize: screen.setSp(40),
                          fontWeight: FontWeight.w600,
                          //fontFamily: FontFamily.uRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screen.setHeight(90),
                    bottom: screen.setHeight(80),
                  ),
                  child: Image.asset(
                    Assets.permission,
                    height: screen.screenHeightDp / 2.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: DefaultButton(
                    "Habilitar",
                    () => controller.enablePermission().then(
                          (bollean) => Modular.to.pushNamedAndRemoveUntil(
                            Modular.initialRoute,
                            (routes) => false,
                          ),
                        ),
                    width: screen.setWidth(screen.width * .8),
                    colorButton: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
