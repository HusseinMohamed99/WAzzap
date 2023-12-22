import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wa_zzap/wazapp_view.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const WAzzap());
}

class WAzzap extends StatelessWidget {
  const WAzzap({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) {
          return const MaterialApp(
            title: 'WAzzap',
            debugShowCheckedModeBanner: false,
            home: WAzzapView(),
          );
        });
  }
}
