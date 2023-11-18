import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hishabkhataproject/screens/input_screen.dart';

import '../bindings/bindings.dart';
import '../config/scroll_behaviour.dart';
import '../localization/local_string.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Open Sans'),
      initialBinding: InitBindings(),
      translationsKeys: AppTranslation.translationsKeys,

      ///  locale: Get.deviceLocale,
      fallbackLocale: const Locale('en_US', 'US'),
      locale: const Locale('en_US', 'US'),
      //  color: Color('0xff78909C'),
      builder: (context, widget) => ScrollConfiguration(
        behavior: const ScrollBehaviorModified(),
        child: widget!,
      ),
      debugShowCheckedModeBanner: false,

      home: InputScreen(),
    );
  }
}
