import 'package:flutter/material.dart';
import 'package:flutter_map_practice/src/base/BaseBindings.dart';
import 'package:flutter_map_practice/src/config/app_config.dart';
import 'package:flutter_map_practice/src/page/home_page.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppConfig.themeData,
      smartManagement: SmartManagement.onlyBuilder,
      initialBinding: BaseBindings(),
      home: const HomePage(),
    );
  }
}
