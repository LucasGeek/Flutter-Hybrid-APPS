import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Screen {
  int width;
  int height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;

  Screen(
      {this.width = 1080, this.height = 1920, this.allowFontScaling = false}) {
    _init();
  }

  _init() {
    MediaQueryData mediaQuery =
        MediaQuery.of(Modular.navigatorKey.currentContext);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  MediaQueryData get mediaQueryData => _mediaQueryData;
  double get textScaleFactory => _textScaleFactor;
  double get pixelRatio => _pixelRatio;
  double get screenWidthDp => _screenWidth;
  double get screenHeightDp => _screenHeight;
  double get screenWidth => _screenWidth * _pixelRatio;
  double get screenHeight => _screenHeight * _pixelRatio;
  double get statusBarHeight => _statusBarHeight * _pixelRatio;
  double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  get scaleWidth => _screenWidth / width;
  get scaleHeight => _screenHeight / height;

  setWidth(double width) => width * scaleWidth;
  setHeight(double height) => height * scaleHeight;
  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}
