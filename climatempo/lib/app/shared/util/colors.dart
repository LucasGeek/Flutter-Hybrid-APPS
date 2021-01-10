import 'dart:ui';

class AppColors {
  //RGB => 44, 62, 80 || HEX => #2c3e50;
  static const Color _primaryColor = const Color(0xFF2C3E50);

  //RGB => 41, 128, 185 || HEX => 2980B9;
  static const Color _secondaryColor = const Color(0xFF2980B9);

  //RGB => 243, 156, 18 || HEX => F39C12;
  static const Color _orangeColor = const Color(0xFFF39C12);

  //RGB => 101, 201, 117 || HEX => 65C975;
  static const Color _greenColor = const Color(0xFF27AE60);

  //RGB => 238, 56, 74 || HEX => EE384A;
  static const Color _redColor = const Color(0xFFEE384A);

  //RGB => 	245, 245, 245 || HEX => F5F5F5;
  static const Color _lightGrayColor = const Color(0xFFF5F5F5);

  //RGB => 244, 244, 248 || HEX => F4F4F8;
  static const Color _grayColor = const Color(0xFFF4F4F8);

  //RGB => 117, 118, 121
  static const Color _darkGrayColor = const Color(0xFF808082);

  //RGB => 225, 225, 225
  static const Color _whiteColor = const Color(0xFFFAFAFA);

  //RGB => 00, 00, 00
  static const Color _blackColor = const Color(0xFF000000);

  //COR PRINCIPAL DO APP
  static const Color primary = _primaryColor;
  //COR PRINCIPAL DO APP INT
  static const int primaryInt = 0xFF2C3E50;
  //COR SECUNDARIA DO APP
  static const Color secondary = _secondaryColor;
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
