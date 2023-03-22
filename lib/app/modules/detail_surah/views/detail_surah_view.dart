import 'package:alquran/app/data/models/detailSurah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SURAH ${surah.name.transliteration?.id!.toUpperCase()}',
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => Get.dialog(Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                color:
                    Get.isDarkMode ? appPurple.withOpacity(0.5) : Colors.white,
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
                          '${surah.name.transliteration?.id}',
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${surah.name.translation?.id!}",
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
          const SizedBox(height: 10),
          FutureBuilder<detail.DetailSurah>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Tidak ada data'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), //Tidak bisa di scrool
                  itemCount: snapshot.data?.verses!.length ?? 0,
                  itemBuilder: (context, index) {
                    if (snapshot.data!.verses!.isEmpty) {
                      return const SizedBox();
                    }
                    detail.Verse ayat = snapshot.data!.verses![index];
                    return Column(
                      children: [
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
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/list.png'),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text('${ayat.number.inSurah}')),
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
                                                        icon: const Icon(
                                                            Icons.pause),
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
                                            middleText:
                                                'Silahkan pilih bookmark',
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  c.addBookmark(
                                                    true,
                                                    snapshot.data!,
                                                    ayat,
                                                    index,
                                                  );
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
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
