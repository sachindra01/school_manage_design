import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const lWhite = Color(0xffffffff);
const lDarkBlack = Color(0xff000000);
const lBlack = Color(0xff121212);
const lGrey = Color(0xfff9f9f9);
const lLightGrey = Color(0xffE8E8E8);
const lBlack2 = Color(0xff1E1E1E);
const lBlack3 = Color(0xff303030);
const lGrey2 = Color(0xff707070);
const lGrey3 = Color(0xffF5F5F5);
const lGrey4 = Color(0xff999999);
const lGreyish = Color(0xffD9D9D9);
const lDividerColor = Color(0xffF2F2F2);
const ltextFieldBorderCol = Color.fromARGB(31, 83, 83, 83);
const lTimeSaleIndicatorColor = Color(0xffF2F2E6);
const lDividerColor2 = Color(0xFFEDEDED);
const lBlue = Color(0xFF0A84FF);
const lRed = Color(0xffB91B33);
const primaryColor = Color.fromARGB(220, 46, 36, 72);
const secondaryColor = Color(0xFFbbbbbb);
const appbarBackgroundColor = Color(0xFFeedebb);
const detailColor = Color(0xFF595757);
const importantColor = Color(0xFFBC0000);
const bgColor = Color(0xFFfbf5f2);
const yellowcolor = Color(0xFFFFA113);
const textColor = Color(0xFF171725);
const tableBgColor = Color(0xFFFAFAFB);
const tableHeaderColor = Color(0xFF92929D);
const tableDataColor = Color(0xFF171725);
const tableHeaderColor1 = Color(0xFF6c6c6c);
const tableImageBgColor = Color(0xFF464646);
const buttonColor = Color(0xFFC6AC45);
const newsDateColor = Color(0xFFBC0000);
const homeMenuTextColor = Color(0xFFb37963);
const greyColor = Color(0xffeedebb);

const yellow = Color(0xfff7c844);
// const bgColor = Color(0xfff8f7f3);
const bgSideMenu = Color(0xff131e29);
const white = Colors.white;
const black = Colors.black;

const kSpacingUnit = 10;
const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);
final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor).copyWith(background: kDarkSecondaryColor),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor).copyWith(background: kLightSecondaryColor),
);
