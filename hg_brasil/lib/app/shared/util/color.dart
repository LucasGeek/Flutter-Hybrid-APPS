import 'dart:ui';

class AppColors {
  //RGB => 114, 123, 245 || HEX => 727CF5;
  static const Color _primaryColor = const Color(0xFF727CF5);

  //RGB => 	102, 102, 204 || HEX => 6666CC;
  static const Color _primaryDarkColor = const Color(0xFF6666CC);

  //RGB => 10, 125, 207 || HEX => 0ACF97;
  static const Color _secondaryColor = const Color(0xFF0ACF97);

  //RGB => 243, 156, 18 || HEX => F39C12;
  static const Color _orangeColor = const Color(0xFFF39C12);

  //RGB => 40, 170, 225 || HEX => 28AAE1;
  static const Color _blueColor = const Color(0xFF28AAE1);

  //RGB => 41, 128, 185 || HEX => 2980B9;
  static const Color _darkBlueColor = const Color(0xFF2980B9);

  //RGB => 101, 201, 117 || HEX => 65C975;
  static const Color _greenColor = const Color(0xFF27AE60);

  //RGB => 238, 56, 74 || HEX => EE384A;
  static const Color _redColor = const Color(0xFFEE384A);

  //RGB => 250, 251, 254 || HEX => FAFBFE;
  static const Color _lightGrayColor = const Color(0xFFFAFBFE);

  //RGB => 244, 244, 248 || HEX => F4F4F8;
  static const Color _grayColor = const Color(0xFFF4F4F8);

  //RGB => 117, 118, 121
  static const Color _darkGrayColor = const Color(0xFF808082);

  //RGB => 225, 225, 225
  static const Color _whiteColor = const Color(0xFFFAFAFA);

  //RGB => 00, 00, 00
  static const Color _blackColor = const Color(0xFF000000);

  ///////////////////////////////////

  //COR PRINCIPAL DO APP INT
  static const int primaryInt = 0xFF727CF5;

  ///////////////////////////////////

  //COR PRINCIPAL DO APP
  static const Color primary = _primaryColor;
  //COR PRINCIPAL DARK DO APP
  static const Color primaryDark = _primaryDarkColor;
  //COR SECUNDARIA DO APP
  static const Color secondary = _secondaryColor;
  // Azul
  static const Color blueColor = _blueColor;
  // Azul Escuro
  static const Color darkBlueColor = _darkBlueColor;
  // Verde
  static const Color greenColor = _greenColor;
  // Laranja
  static const Color orangeColor = _orangeColor;
  // Vermelho
  static const Color redColor = _redColor;
  // Vermelho
  static const Color whiteColor = _whiteColor;

  // Cinza
  static const Color grayColor = _grayColor;
  // Cinza claro
  static const Color lightGrayColor = _lightGrayColor;
  // Cinza Escuro
  static const Color darkGrayColor = _darkGrayColor;

  //COR BACKGROUND
  static const Color background = _grayColor;
  //COR BACKGROUND LIGHT
  static const Color backgroundLight = _lightGrayColor;

  //COR BACKGROUND LIGHT
  static const Color blackColor = _blackColor;
}
