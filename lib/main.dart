import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/pages.dart';
import 'app/routes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Influbee",
    initialRoute: AppRoutes.SPLASH,
    getPages: AppPages.routes,
  ));
}
