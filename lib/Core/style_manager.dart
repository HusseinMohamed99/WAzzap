import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wa_zzap/Core/color_manager.dart';

class StyleManager {
  static TextStyle font15 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.blackColor,
  );
  static TextStyle font18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.blackColor,
  );
  static TextStyle font13LighterGrayRegular = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.grayColor,
  );
}
