import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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

const defaultPadding = 16.0;

actionButtonStyle() {
  return ElevatedButton.styleFrom(backgroundColor: buttonColor);
}

const contactTitleText =
    TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

const contactMenuText =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
// const contactMenuButton = ElevatedButton.styleFrom();

ralewayRegular(color, double fontsize, double letterSpacing) =>
    GoogleFonts.raleway(
      fontSize: fontsize.sp,
      fontWeight: FontWeight.normal,
      color: color,
      letterSpacing: letterSpacing,
    );
ralewayRegularLineHeight(
        color, double fontsize, double letterSpacing, lineHeight) =>
    GoogleFonts.raleway(
        fontSize: fontsize.sp,
        fontWeight: FontWeight.normal,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
ralewaySemiBold(color, double fontsize) => GoogleFonts.raleway(
      fontSize: fontsize.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
ralewayBold(color, double fontsize) => GoogleFonts.raleway(
    fontSize: fontsize.sp, fontWeight: FontWeight.bold, color: color);
ralewayLight(color, double fontsize, double letterSpacing) =>
    GoogleFonts.raleway(
      fontSize: fontsize.sp,
      fontWeight: FontWeight.w300,
      color: color,
      letterSpacing: letterSpacing,
    );
ralewayLightLineHeight(
        color, double fontsize, double letterSpacing, lineHeight) =>
    GoogleFonts.raleway(
        fontSize: fontsize.sp,
        fontWeight: FontWeight.w300,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight);
ralewayLightOpacity(color, double fontsize, double letterSpacing, opacity) =>
    GoogleFonts.raleway(
      fontSize: fontsize.sp,
      fontWeight: FontWeight.w300,
      color: color.withOpacity(opacity),
      letterSpacing: letterSpacing,
    );
ralewayItalicLight(color, double fontsize) => GoogleFonts.raleway(
    fontSize: fontsize.sp,
    fontWeight: FontWeight.w300,
    color: color,
    textStyle: const TextStyle(fontStyle: FontStyle.italic));
ralewayItalic(color, double fontsize) => GoogleFonts.raleway(
    fontSize: fontsize.sp,
    fontWeight: FontWeight.normal,
    color: color,
    textStyle: const TextStyle(fontStyle: FontStyle.italic));
ralewayMedium(color, double fontsize) => GoogleFonts.raleway(
    fontSize: fontsize.sp,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0);
ralewayMediumLineHeight(color, double fontsize, lineHeight) =>
    GoogleFonts.raleway(
        fontSize: fontsize.sp,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0,
        height: lineHeight);

helveticaRegular(color, double fontsize) => TextStyle(
    fontFamily: 'Helvetica',
    fontSize: fontsize.sp,
    color: color,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5);

avenirNextRegular(color, double fontSize) => TextStyle(
    fontFamily: 'Avenir Next Condensed',
    fontSize: fontSize.sp,
    color: color,
    fontWeight: FontWeight.w400,
    letterSpacing: 0);
avenirNextRegularLetterSpacing(color, double fontSize, letterSpacing) =>
    TextStyle(
        fontFamily: 'Avenir Next Condensed',
        fontSize: fontSize.sp,
        color: color,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing);

avenirNextMedium(color, double fontSize) => TextStyle(
    fontFamily: 'Avenir Next Condensed',
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0);
avenirNextMediumSpacing(color, double fontSize, double letterSpacing,
        [lineheight]) =>
    TextStyle(
        fontFamily: 'Avenir Next Condensed',
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: letterSpacing,
        height: lineheight);
avenirNextMediumLineHeight(color, double fontSize, lineHeight) => TextStyle(
    fontFamily: 'Avenir Next Condensed',
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0,
    height: lineHeight);
avenirNextMediumUnderline(color, double fontSize) => TextStyle(
    fontFamily: 'Avenir Next Condensed',
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0,
    decoration: TextDecoration.lineThrough,
    decorationThickness: 2.sp,
    decorationColor: lBlack.withOpacity(0.8),
    decorationStyle: TextDecorationStyle.solid);

ColorFilter lFilter =
    ColorFilter.mode(lBlack.withOpacity(0.8), BlendMode.multiply);
