import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const azanTimeStyle =
      TextStyle(fontSize: 15, color: Colors.black, fontFamily: "ff");

  static const todayTimeTextStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontFamily: "ff");
  static const navTextStyle = TextStyle(fontSize: 15, color: Colors.white);
  static const quranFahrasTitleTextStyle =
      TextStyle(fontSize: 20, color: Colors.white);
  static const quranBarTextStyle = TextStyle(fontSize: 15, color: Colors.white);
  static const azanTimeTitleTextStyle =
      TextStyle(fontSize: 25, color: Colors.white);
  static const timeTimerTextStyle =
      TextStyle(fontSize: 15, color: Colors.white, fontFamily: "ff");

  static const wrdTitleTextStyle = TextStyle(fontSize: 20, fontFamily: "gg");
  static const wrdTitleTextStyle2 =
      TextStyle(fontSize: 17, fontFamily: "gg", color: Colors.black);
  static const wrdTitleTextStyle3 =
      TextStyle(fontSize: 17, fontFamily: "ff", color: Colors.black);
  static const deleteInfoTextStyle =
      TextStyle(fontSize: 20, color: Colors.white);

  static final linearTitle = LinearGradient(
      colors: [Colors.white.withOpacity(0.05), Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static final linearPointer = LinearGradient(
      colors: [AppColors.mainColor, AppColors.mainColorSelected],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static final linearPointerTers = LinearGradient(
      colors: [AppColors.mainColor, AppColors.mainColorSelected],
      transform: GradientRotation(1),
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const titleTextStyle = TextStyle(fontSize: 40, color: Colors.black);
  static const miniFahrasTextStyle =
      TextStyle(fontSize: 30, color: Colors.black);
  static final pageTitleStyle =
      TextStyle(fontSize: 30, color: AppColors.addColor);
  static const buttonTextStyle = TextStyle(fontSize: 30, color: Colors.white);
  static const counterTextStyle =
      TextStyle(fontSize: 40, color: Colors.white, fontFamily: "ff");
}

class AppColors {
  static final mainColor = Color(0xffD88E65);
  static final mainColorSelected = Color(0xff994D23);
  static final deleteColor = Color(0xffe63946);
  static final addColor = Color(0xff4ecdc4);
  static final surahColor = Color(0xffEAAA87);

  static final adanNormal = Color(0xffD5C0B4);
  static final adanActive = Color(0xffDAD222);
  static final adanNotificationCircle = Color(0xffD88E65);
  // static final adanNotificationPill = Color(0xffD88E65);
}
