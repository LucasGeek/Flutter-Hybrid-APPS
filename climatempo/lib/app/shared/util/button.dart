import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'colors.dart';
import 'loading.dart';
import 'screen.dart';

class DefaultButton extends StatelessWidget {
  final String buttonCaption;
  final Function functionCallback;
  final Color colorButton;
  final Color colorButtonBorder;
  final Color colorText;
  final double borderRadius;
  final Widget icon;
  final double width;
  final double height;
  final ProgressButtonType typeButton;
  final ProgressButtonState typeButtonState;

  const DefaultButton(
    this.buttonCaption,
    this.functionCallback, {
    this.colorButton = AppColors.secondary,
    this.colorText = AppColors.whiteColor,
    this.colorButtonBorder = AppColors.whiteColor,
    this.icon,
    this.width,
    this.height = 140.0,
    this.borderRadius = 50.0,
    this.typeButton = ProgressButtonType.Raised,
    this.typeButtonState = ProgressButtonState.Default,
  });

  @override
  Widget build(BuildContext context) {
    final screen = Modular.get<Screen>();

    return ProgressButton(
      defaultWidget: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: this.icon,
                ),
                Container(
                  child: Text(
                    this.buttonCaption,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: this.colorText,
                      fontSize: screen.setSp(38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          : Text(
              this.buttonCaption,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: this.colorText,
                fontSize: screen.setSp(38),
                fontWeight: FontWeight.bold,
              ),
            ),
      onPressed: this.functionCallback,
      color: this.colorButton,
      //colorBorder: this.colorButtonBorder,
      height: screen.setHeight(this.height),
      width: this.width,
      borderRadius: this.borderRadius,
      animate: true,
      type: this.typeButton,
      progressWidget: ThreeSizeDot(),
      progressButtonState: this.typeButtonState,
    );
  }
}
