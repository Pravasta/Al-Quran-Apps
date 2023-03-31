import 'package:alquran/app/data/models/detailSurah.dart' as detail;
import 'package:alquran/app/modules/home/controllers/home_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../constant/color.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SURAH ${Get.arguments['name'].toString().toUpperCase()}',
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<detail.DetailSurah>(
        future: controller.getDetailSurah(Get.arguments['number'].toString()),
        // Snapshot akan berubah menjadi detail surah
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Tidak ada Data',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          }

          // Ini diugnakan untuk mendapatkan data bookmark buat melakukan scrool to index jika dibuka via bookmark
          if (Get.arguments['bookmark'] != null) {
            bookmark = Get.arguments['bookmark'];
            controller.scrollC.scrollToIndex(
              // + 2 dikarenakan index scrool dimulai dari gesture Detector
              bookmark!['index_ayat'] + 2,
              preferPosition: AutoScrollPosition.begin,
            );
          }
          print(bookmark);

          detail.DetailSurah surah = snapshot.data!;

          // Karena ListView Builder tidak dapat di autoscrool / jika dipaksa hasil nya jelek, maka perlu dibuat ini
          List<Widget> allAyat = List.generate(
            snapshot.data?.verses!.length ?? 0,
            (index) {
              detail.Verse ayat = snapshot.data!.verses![index];
              return AutoScrollTag(
                controller: controller.scrollC,
                key: ValueKey(index + 2),
                index: index + 2,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Get.isDarkMode
                            ? appPurple.withOpacity(0.4)
                            : appPurple.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/list.png'),
                                ),
                              ),
                              child:
                                  Center(child: Text('${ayat.number.inSurah}')),
                            ),
                            GetBuilder<DetailSurahController>(
                              builder: (c) => Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.share,
                                    ),
                                  ),
                                  (ayat.kondisiAudio == 'stop')
                                      ? IconButton(
                                          onPressed: () {
                                            c.playAudio(ayat);
                                          },
                                          icon: const Icon(
                                            Icons.play_arrow,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (ayat.kondisiAudio == 'playing')
                                                ? IconButton(
                                                    onPressed: () =>
                                                        c.pauseAudio(ayat),
                                                    icon:
                                                        const Icon(Icons.pause),
                                                  )
                                                : IconButton(
                                                    onPressed: () =>
                                                        c.resumeAudio(ayat),
                                                    icon: const Icon(
                                                        Icons.play_arrow),
                                                  ),
                                            IconButton(
                                              onPressed: () =>
                                                  c.stopAudio(ayat),
                                              icon: const Icon(Icons.stop),
                                            ),
                                          ],
                                        ),
                                  IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'BOOKMARK',
                                        middleText: 'Silahkan pilih bookmark',
                                        actions: [
                                          ElevatedButton(
                                            // dibauh async karena biar menunggu dulu proses atas selesai baru melakukan homeC update
                                            onPressed: () async {
                                              await c.addBookmark(
                                                true,
                                                snapshot.data!,
                                                ayat,
                                                index,
                                              );
                                              // update dipindah kesini agar tidak mengalami error
                                              homeC.update();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: appPurple),
                                            child: const Text('Last Read'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              c.addBookmark(
                                                false,
                                                snapshot.data!,
                                                ayat,
                                                index,
                                              );
                                              homeC.update();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: appPurple),
                                            child: const Text('Bookmark'),
                                          ),
                                        ],
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.bookmark_outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ayat.text.arab,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ayat.text.transliteration.en,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${ayat.translation.id}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );

          // Sudah dipastikan ada data
          return ListView(
            controller: controller.scrollC,
            padding: const EdgeInsets.all(20),
            children: [
              AutoScrollTag(
                controller: controller.scrollC,
                key: const ValueKey(0),
                index: 0,
                child: GestureDetector(
                  onTap: () => Get.dialog(Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Get.isDarkMode
                          ? appPurple.withOpacity(0.5)
                          : Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Tafsir',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${surah.tafsir.id}',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffDF98FA),
                          appPurpleLight,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: -67,
                          right: 1,
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Opacity(
                              opacity: 0.1,
                              child: Image.asset(
                                'assets/images/Quran.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${surah.name.transliteration.id}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                surah.name.translation.id!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                              ),
                              Text(
                                '${surah.revelation.id!} || ${surah.numberOfVerses} Ayat ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${surah.name.long} ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Poppins',
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
              AutoScrollTag(
                controller: controller.scrollC,
                key: const ValueKey(1),
                index: 1,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              ...allAyat,
            ],
          );
        },
      ),
    );
  }
}
