
import 'package:flutter/material.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppFontSizes.dart';


class AppTextStyle{

  static TextStyle inputStyle(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: Colors.grey);
  }

  static TextStyle inputLabelStyle(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Colors.grey);
  }

  // For snackbar/Toast text
  static TextStyle snackbar(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Colors.green);
  }

  // For headers
  static TextStyle header(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.largest,
        fontWeight: FontWeight.w700,
        color: Colors.grey);
  }

  // For small headers
  static TextStyle editTextSmall(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["Lobster"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w500,
        color: AppColor().success);
  }
  static TextStyle error(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["Lobster"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w800,
        color: Colors.red);
  }
  static TextStyle help(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["Lobster"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w800,
        color: AppColor().success);
  }
  static TextStyle siginText(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["Lobster"],
        fontSize: 14.0,
        fontWeight: FontWeight.w800,
        color: Colors.deepPurple);

  }

  static TextStyle headerSmall(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w500,
        color: AppColor.deep);
  }
  static TextStyle emailheaderSmall(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w500,
        color: AppColor.orange);
  }
  static TextStyle headerSmallWhite(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w500,
        color: Colors.white);
  }

  static TextStyle headerSmallWhite2(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.smallest,
        fontWeight: FontWeight.w500,
        color: Colors.white);
  }
  static TextStyle headerSmall2(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }

  static TextStyle headerSmaller(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.smallest,
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }

  static TextStyle headerSmall3(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: AppColor.thirdColor);
  }
  static TextStyle headerSmall3_1(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: AppColor.d);
  }

  static TextStyle inputHint(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w500,
        color: Colors.grey);
  }

  static TextStyle h2(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.large,
        fontWeight: FontWeight.bold,
        color: Colors.black87);
  }

}
