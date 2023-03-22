import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/modules/home/views/Tab%20Bar/bookmark.dart';
import 'package:alquran/app/modules/home/views/Tab%20Bar/juztab.dart';
import 'package:alquran/app/modules/home/views/Tab%20Bar/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Al-Quran Apps',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH_PAGE),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assalamualaikum',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffDF98FA),
                      appPurpleLight,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: SizedBox(
                      height: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -55,
                            right: 1,
                            child: SizedBox(
                              width: 210,
                              height: 210,
                              child: Image.asset(
                                'assets/images/Quran.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Terakhir Dibaca',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Al-Fatihah',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'Juz 1 | Ayat no. 5',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const TabBar(
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                ),
                tabs: [
                  Tab(
                    text: 'Surah',
                  ),
                  Tab(
                    text: 'Juz',
                  ),
                  Tab(
                    text: 'Bookmarks',
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SurahTab(),
                    JuzTab(),
                    BookmarkClass(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeTheme(),
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appGelapMode : Colors.white,
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) {},
      //   backgroundColor: Get.isDarkMode ? appGelapMode : Colors.white,
      //   elevation: 4,
      //   selectedItemColor: appPurpleLight,
      //   unselectedItemColor: appGrey,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_outlined,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.light_mode_outlined,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.bookmark_outline,
      //       ),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }
}
