import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MirrorHubApp extends StatelessWidget {
  const MirrorHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 850.9090909090909),
        builder: (context, child) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.config(),
              theme: ThemeData(fontFamily: 'poppins'),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: (context, child) {
                final textScale = MediaQuery.of(context).textScaleFactor;
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(
                          textScale >= 1.1 ? 1.1 : textScale)),
                  child: child!,
                );
              },
            ));
  }
}
