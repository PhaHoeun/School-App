import 'package:flutter/material.dart';

extension AppColor on Color {
  //***************************************************************
  //##########--Main Color--##########=>Pha
  //***************************************************************

  //light----------------------------------------------------------
  static var primaryLightColor = const Color(0xff018F99);
  static var secondaryLightColor = const Color.fromARGB(255, 101, 221, 236);
  static var backgroundLightColor = const Color(0xfffbfbfb);
  static var disableLightColor = const Color(0xffF5F5F5);
  static var cardLightColor = Colors.white;
  static var dividerLightColor = Colors.black12;
  //text color light
  static var titleTextAppbarLightColor = Colors.white;
  static var textLightColor = Colors.black;
  static var subTextLightColor = Colors.black.withValues(alpha: 0.6);
  static var textWhiteWhenLightColor = Colors.white;

  //***************************************************************
  //##########--Fix Color--##########=>Pha
  //***************************************************************
  static var tapBarColor = const Color(0xff12B8E2);
  //responce color
  static var warningColor = const Color(0xffE2C90B);
  static var dangerColor = const Color(0xffff2b2b);
  static var successColor = const Color(0xff3ED63B);
}
