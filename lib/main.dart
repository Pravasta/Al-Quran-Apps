import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();

  runApp(
    GetMaterialApp(
      theme: box.read('themeGelap') == null ? themaTerang : themaGelap,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
