import 'package:flutter/material.dart';
import 'app_colors.dart';

TextStyle anyStyle({
  required TextStyle start,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double? letterSpacing,
  double? height,
  double? decorationThickness,
  Color? decorationColor,
  List<Shadow>? shadows,
}) {
  start = start.copyWith(color: color);
  start = start.copyWith(fontSize: fontSize);
  start = start.copyWith(fontWeight: fontWeight);
  start = start.copyWith(decoration: decoration);
  start = start.copyWith(letterSpacing: letterSpacing);
  start = start.copyWith(height: height);
  start = start.copyWith(decorationThickness: decorationThickness);
  start = start.copyWith(decorationColor: decorationColor);
  start = start.copyWith(shadows: shadows);
  return start;
}

TextStyle start = const TextStyle(fontSize: 12, color: simplyBlack, fontWeight: FontWeight.normal);
// TextStyle whiteButtonText = GoogleFonts.roboto(fontSize: 14, color: simplyWhite, fontWeight: FontWeight.w600);
// TextStyle footerStyle = GoogleFonts.roboto(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400, height: 1.33);
TextStyle unfocussed = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: simplyWhite, height: 1, letterSpacing: 1.2);

TextStyle focussed = anyStyle(
  start: unfocussed,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.underline,
  decorationThickness: 2,
  decorationColor: Colors.white,
  color: Colors.transparent,
  height: 1.6,
  letterSpacing: 1,
  shadows: [const Shadow(offset: Offset(0, -2), color: Colors.white)],
);
TextStyle drawerMenu = anyStyle(
  start: start,
  color: simplyWhite,
);
TextStyle skillsHeader = anyStyle(start: start, fontWeight: FontWeight.bold, fontSize: 20);
TextStyle skillsBody = anyStyle(start: start, fontSize: 16);
TextStyle skillsBodySmall = anyStyle(start: start, fontSize: 13);
TextStyle footerBig = anyStyle(start: start, fontWeight: FontWeight.bold, fontSize: 16);
TextStyle footerSmall = anyStyle(start: start, fontWeight: FontWeight.w600, fontSize: 12);

TextStyle getContextStyle(BuildContext context) {
  return anyStyle(start: start, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700, fontSize: 24);
}

TextStyle getContextHelperStyle(BuildContext context) {
  return anyStyle(start: start, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 12);
}

TextStyle oppositeWay(BuildContext context) {
  return anyStyle(start: getContextHelperStyle(context), color: Theme.of(context).colorScheme.primary);
}

TextStyle smallPrimary(BuildContext context) => anyStyle(start: oppositeWay(context), fontSize: 16);

TextStyle getDialogHeaderStyle(BuildContext context) {
  return anyStyle(start: getContextHelperStyle(context), fontSize: 16);
}

TextStyle getGoodResult(BuildContext context) {
  return anyStyle(start: getContextHelperStyle(context), fontSize: 30, fontWeight: FontWeight.bold);
}
