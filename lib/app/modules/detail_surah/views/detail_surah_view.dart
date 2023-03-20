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
        title: Text('SURAH ${surah.name.transliteration?.id!.toUpperCase()}'),
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
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${surah.tafsir.id}',
                      textAlign: TextAlign.justify,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller
                                            .playAudio(ayat.audio.primary);
                                      },
                                      icon: const Icon(
                                        Icons.play_arrow,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark_outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          ayat.text.arab,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ayat.text.transliteration.en,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
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
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 40),
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
