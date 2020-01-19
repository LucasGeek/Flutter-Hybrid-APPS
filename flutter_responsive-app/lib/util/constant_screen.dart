import 'package:flutter/material.dart';
import 'package:flutter_responsive_app/util/screen_util/font_screen.dart';
import 'package:flutter_responsive_app/util/screen_util/percentage_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//iPhone6 ​​(iPhone6 ​​750*1334)

double defaultScreenWidth = 750.0;
double defaultScreenHeight = 1334.0;

double responsiveScreenWidth = defaultScreenWidth;
double responsiveScreenHeight = defaultScreenHeight;

class ConstantScreen extends PorcentageScreen {
  /*Padding & Margin Constants*/
  static double sizeWidth1 = 1.0;
  static double sizeWidth2 = 2.0;
  static double sizeWidth3 = 3.0;
  static double sizeWidth4 = 4.0;
  static double sizeWidth5 = 5.0;
  static double sizeWidth6 = 6.0;
  static double sizeWidth7 = 7.0;
  static double sizeWidth8 = 8.0;
  static double sizeWidth9 = 9.0;
  static double sizeWidth10 = 10.0;
  static double sizeWidth15 = 15.0;
  static double sizeWidth20 = 20.0;
  static double sizeWidth30 = 30.0;
  static double sizeWidth40 = 40.0;
  static double sizeWidth50 = 50.0;
  static double sizeWidth60 = 60.0;
  static double sizeWidth70 = 70.0;
  static double sizeWidth80 = 80.0;
  static double sizeWidth90 = 90.0;
  static double sizeWidth100 = 100.0;

  static double sizeHeight1 = 1.0;
  static double sizeHeight2 = 2.0;
  static double sizeHeight3 = 3.0;
  static double sizeHeight4 = 4.0;
  static double sizeHeight5 = 5.0;
  static double sizeHeight6 = 6.0;
  static double sizeHeight7 = 7.0;
  static double sizeHeight8 = 8.0;
  static double sizeHeight9 = 9.0;
  static double sizeHeight10 = 10.0;
  static double sizeHeight15 = 15.0;
  static double sizeHeight20 = 20.0;
  static double sizeHeight30 = 30.0;
  static double sizeHeight40 = 40.0;
  static double sizeHeight50 = 50.0;
  static double sizeHeight60 = 60.0;
  static double sizeHeight70 = 70.0;
  static double sizeHeight80 = 80.0;
  static double sizeHeight90 = 90.0;
  static double sizeHeight100 = 100.0;

  /*Screen Size dependent Constants*/
  static double screenWidth1 = defaultScreenWidth / 1;
  static double screenWidth2 = defaultScreenWidth / 2;
  static double screenWidth3 = defaultScreenWidth / 3;
  static double screenWidth4 = defaultScreenWidth / 4;
  static double screenWidth5 = defaultScreenWidth / 5;
  static double screenWidth6 = defaultScreenWidth / 6;
  static double screenWidth7 = defaultScreenWidth / 7;
  static double screenWidth8 = defaultScreenWidth / 8;
  static double screenWidth9 = defaultScreenWidth / 9;
  static double screenWidth10 = defaultScreenWidth / 10;

  static double screenHeight1 = defaultScreenHeight / 1;
  static double screenHeight2 = defaultScreenHeight / 2;
  static double screenHeight3 = defaultScreenHeight / 3;
  static double screenHeight4 = defaultScreenHeight / 4;
  static double screenHeight5 = defaultScreenHeight / 5;
  static double screenHeight6 = defaultScreenHeight / 6;
  static double screenHeight7 = defaultScreenHeight / 7;
  static double screenHeight8 = defaultScreenHeight / 8;
  static double screenHeight9 = defaultScreenHeight / 9;
  static double screenHeight10 = defaultScreenHeight / 10;

  /*Image Dimensions*/
  static double defaultIconSize = 80.0;
  static double defaultImageHeight = 120.0;
  static double snackBarHeight = 50.0;
  static double textIconSize = 30.0;

  /*EdgeInsets*/
  static EdgeInsets spacingAllDefault = EdgeInsets.all(sizeWidth10);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(sizeWidth8);

  static void setScreenAwareConstant(context) {
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);

    FontScreen.setScreenAwareFontSize();

    /*Padding & Margin Constants*/
    sizeWidth1 = ScreenUtil().setWidth(1.0);
    sizeWidth2 = ScreenUtil().setWidth(2.0);
    sizeWidth3 = ScreenUtil().setWidth(3.0);
    sizeWidth4 = ScreenUtil().setWidth(4.0);
    sizeWidth5 = ScreenUtil().setWidth(5.0);
    sizeWidth6 = ScreenUtil().setWidth(6.0);
    sizeWidth7 = ScreenUtil().setWidth(7.0);
    sizeWidth8 = ScreenUtil().setWidth(8.0);
    sizeWidth9 = ScreenUtil().setWidth(9.0);
    sizeWidth10 = ScreenUtil().setWidth(10.0);
    sizeWidth15 = ScreenUtil().setWidth(15.0);
    sizeWidth20 = ScreenUtil().setWidth(20.0);
    sizeWidth30 = ScreenUtil().setWidth(30.0);
    sizeWidth40 = ScreenUtil().setWidth(40.0);
    sizeWidth50 = ScreenUtil().setWidth(50.0);
    sizeWidth60 = ScreenUtil().setWidth(60.0);
    sizeWidth70 = ScreenUtil().setWidth(70.0);
    sizeWidth80 = ScreenUtil().setWidth(80.0);
    sizeWidth90 = ScreenUtil().setWidth(90.0);
    sizeWidth100 = ScreenUtil().setWidth(100.0);

    sizeHeight1 = ScreenUtil().setHeight(1.0);
    sizeHeight2 = ScreenUtil().setHeight(2.0);
    sizeHeight3 = ScreenUtil().setHeight(3.0);
    sizeHeight4 = ScreenUtil().setHeight(4.0);
    sizeHeight5 = ScreenUtil().setHeight(5.0);
    sizeHeight6 = ScreenUtil().setHeight(6.0);
    sizeHeight7 = ScreenUtil().setHeight(7.0);
    sizeHeight8 = ScreenUtil().setHeight(8.0);
    sizeHeight9 = ScreenUtil().setHeight(9.0);
    sizeHeight10 = ScreenUtil().setHeight(10.0);
    sizeHeight15 = ScreenUtil().setHeight(15.0);
    sizeHeight20 = ScreenUtil().setHeight(20.0);
    sizeHeight30 = ScreenUtil().setHeight(30.0);
    sizeHeight40 = ScreenUtil().setHeight(40.0);
    sizeHeight50 = ScreenUtil().setHeight(50.0);
    sizeHeight60 = ScreenUtil().setHeight(60.0);
    sizeHeight70 = ScreenUtil().setHeight(70.0);
    sizeHeight80 = ScreenUtil().setHeight(80.0);
    sizeHeight90 = ScreenUtil().setHeight(90.0);
    sizeHeight100 = ScreenUtil().setHeight(100.0);

    /*Screen Size dependent Constants*/
    screenWidth1 = ScreenUtil.screenWidth / 1;
    screenWidth2 = ScreenUtil.screenWidth / 2;
    screenWidth3 = ScreenUtil.screenWidth / 3;
    screenWidth4 = ScreenUtil.screenWidth / 4;
    screenWidth5 = ScreenUtil.screenWidth / 5;
    screenWidth6 = ScreenUtil.screenWidth / 6;
    screenWidth7 = ScreenUtil.screenWidth / 7;
    screenWidth8 = ScreenUtil.screenWidth / 8;
    screenWidth9 = ScreenUtil.screenWidth / 9;
    screenWidth10 = ScreenUtil.screenWidth / 10;

    screenHeight1 = ScreenUtil.screenHeight / 1;
    screenHeight2 = ScreenUtil.screenHeight / 2;
    screenHeight3 = ScreenUtil.screenHeight / 3;
    screenHeight4 = ScreenUtil.screenHeight / 4;
    screenHeight5 = ScreenUtil.screenHeight / 5;
    screenHeight6 = ScreenUtil.screenHeight / 6;
    screenHeight7 = ScreenUtil.screenHeight / 7;
    screenHeight8 = ScreenUtil.screenHeight / 8;
    screenHeight9 = ScreenUtil.screenHeight / 9;
    screenHeight10 = ScreenUtil.screenHeight / 10;

    /*Image Dimensions*/
    defaultIconSize = ScreenUtil().setWidth(80.0);
    defaultImageHeight = ScreenUtil().setWidth(120.0);
    snackBarHeight = ScreenUtil().setWidth(50.0);
    textIconSize = ScreenUtil().setWidth(30.0);

    /*EdgeInsets*/
    spacingAllDefault = EdgeInsets.all(sizeWidth10);
    spacingAllSmall = EdgeInsets.all(sizeWidth8);
  }
}
