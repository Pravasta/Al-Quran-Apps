import 'package:alquran/app/data/models/juz.dart' as j;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/color.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  DetailJuzView({Key? key}) : super(key: key);

  final j.Juz detailJuz = Get.arguments['juz'];
  final List<Surah> allSurahInJuz = Get.arguments['surah'];
  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // for (var element in allSurahInJuz) {
    //   print(element.name.transliteration!.id);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('JUZ ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            //Tidak dapat di scrooll, Untuk mengatasi dapat di bungkus dengan widget ListView biasa
            padding: const EdgeInsets.all(20),
            itemCount: detailJuz.verses!.length,
            itemBuilder: (context, index) {
              if (detailJuz.verses!.isEmpty || detailJuz.verses == null) {
                return const Center(
                  child: Text(
                    'Tidak ada data',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              }
              j.Verse ayat = detailJuz.verses![index];

              // detail.DetailSurah surah = ayat;

              // // Untuk membagi surah surah dgn jumlah ayat dalam juz
              // if (index != 0) {
              //   if ((ayat['ayat'] as detail.Verse).number.inSurah == 1) {
              //     controller.index++;
              //   }
              // }

              if (index != 0) {
                if (ayat.number.inSurah == 1) {
                  controller.test++;
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (ayat.number.inSurah == 1)
                    GestureDetector(
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
                                    fontSize: 20, fontFamily: 'Poppins'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                ayat.tafsir.id.short,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                      )),
                      // onTap: () => Get.defaultDialog(
                      //   backgroundColor:
                      //       Get.isDarkMode ? appPurple.withOpacity(0.5) : Colors.white,
                      //   contentPadding: const EdgeInsets.symmetric(
                      //     vertical: 15,
                      //     horizontal: 30,
                      //   ),
                      //   title: 'Tafsir',
                      //   content: SizedBox(
                      //     child: Text(
                      //       '${surah.tafsir.id}',
                      //       textAlign: TextAlign.justify,
                      //     ),
                      //   ),
                      // ),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(bottom: 30),
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
                                width: Get.width,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${allSurahInJuz[controller.test.value].name.transliteration?.id}',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${allSurahInJuz[controller.test.value].name.translation?.id}",
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
                                    '${allSurahInJuz[controller.test.value].revelation.id!} || ${allSurahInJuz[controller.test.value].numberOfVerses} Ayat ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${allSurahInJuz[controller.test.value].name.long} ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/list.png'),
                                  ),
                                ),
                                child: Center(
                                    child: Text('${ayat.number.inSurah}')),
                              ),
                              Text(
                                '${allSurahInJuz[controller.test.value].name.transliteration?.id}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<DetailJuzController>(
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
                                                  icon: const Icon(Icons.pause),
                                                )
                                              : IconButton(
                                                  onPressed: () =>
                                                      c.resumeAudio(ayat),
                                                  icon: const Icon(
                                                      Icons.play_arrow),
                                                ),
                                          IconButton(
                                            onPressed: () => c.stopAudio(ayat),
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
                                          onPressed: () async {
                                            await c.addBookmark(
                                              true,
                                              allSurahInJuz[
                                                  controller.test.value],
                                              ayat,
                                              index,
                                            );
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
                                              allSurahInJuz[
                                                  controller.test.value],
                                              ayat,
                                              index,
                                            );
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
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
                  Text(
                    ayat.text.transliteration.en,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    '${ayat.translation.id}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
