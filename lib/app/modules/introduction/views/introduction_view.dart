import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Al-Quran Apps',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Sudah kah anda membaca Al-Quran hari ini ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Get.isDarkMode ? appGreyDark : appGrey,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/intro.png',
              fit: BoxFit.cover,
              width: 350,
              height: 500,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'GET STARTED',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? appGelapMode : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
