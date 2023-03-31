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
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverToBoxAdapter(
                child: _introducing(),
              ),
              Obx(
                () => SliverAppBar(
                  backgroundColor:
                      controller.isDark.isTrue ? purpleBottom : Colors.white,
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: _tab(),
                  ),
                ),
              ),
            ],
            body: _listTabbar(),
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

  TabBarView _listTabbar() {
    return const TabBarView(
      children: [
        SurahTab(),
        JuzTab(),
        BookmarkClass(),
      ],
    );
  }

  TabBar _tab() {
    return TabBar(
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
      ),
      tabs: [
        _tabItem(text: 'Surah'),
        _tabItem(text: 'Juz'),
        _tabItem(text: 'Bookmark'),
      ],
    );
  }

  Tab _tabItem({required String text}) {
    return Tab(
      text: text,
    );
  }
}

class _introducing extends GetView<HomeController> {
  const _introducing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            'Assalamualaikum',
            style: TextStyle(
              color: controller.isDark.isTrue ? Colors.white : purpleBottom,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GetBuilder<HomeController>(
          builder: (c) => FutureBuilder<Map<String, dynamic>?>(
            future: controller.getLastRead(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
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
                                  'Loading..',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                const Text(
                                  '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              Map<String, dynamic>? lastRead = snapshot.data;

              return Container(
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
                    onLongPress: () {
                      if (lastRead != null) {
                        Get.defaultDialog(
                          title: 'Menghapus LastRead',
                          middleText:
                              'Apakah kamu yakin akan menghapus last Read ?',
                          actions: [
                            OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text('Batalkan'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.deleteBookmark(lastRead['id']);
                                Get.back();
                              },
                              child: const Text('Yakin'),
                            ),
                          ],
                        );
                      }
                    },
                    onTap: () {
                      if (lastRead != null) {
                        switch (lastRead['via']) {
                          case 'juz':
                            print('GO TO JUS');
                            // Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                            //   'juz': detailJuz,
                            //   'surah': allSurahInJuz,
                            //   'bookmark': lastRead,
                            // });
                            break;
                          default:
                            Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                              'name': lastRead['surah']
                                  .toString()
                                  .replaceAll('+', "'"),
                              'number': lastRead['number_surah'],
                              // Membawa lastRead lengkap dari bookmark juga
                              'bookmark': lastRead,
                            });
                        }
                      }
                    },
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
                                Text(
                                  lastRead == null
                                      ? ''
                                      : lastRead['surah']
                                          .toString()
                                          .replaceAll('+', "'"),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text(
                                  lastRead == null
                                      ? 'Belum ada data'
                                      : 'Juz ${lastRead['juz']} | Ayat no.${lastRead['ayat']}',
                                  style: const TextStyle(
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
              );
            },
          ),
        ),
      ],
    );
  }
}
