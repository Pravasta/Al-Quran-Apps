import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/detailSurah.dart' as detail;
import 'package:alquran/app/data/models/juz.dart' as j;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class JuzTab extends GetView<HomeController> {
  const JuzTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<j.Juz>>(
      future: controller.getAllJuz(),
      // Ubah snapshot agar menjadi list surah
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // print(snapshot.data); untuk cek apakah sudah ada datanya lalu tinggal pakai

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak ada data.'),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            // Mengambil data
            j.Juz detailJuz = snapshot.data![index];

            // Setelah di split akan menghasil kan dalam bentuk index [nama surah, ayat]
            String awalSurat = detailJuz.juzStartInfo?.split(' - ').first ?? '';
            String akhirSurat = detailJuz.juzEndInfo?.split(' - ').first ?? '';

            List<detail.DetailSurah> rawAllSurahInJuz = [];
            List<detail.DetailSurah> allSurahInJuz = [];

            for (detail.DetailSurah item in controller.allSurah) {
              rawAllSurahInJuz.add(item);
              if (item.name.transliteration.id == akhirSurat) {
                break;
              }
            }
            for (detail.DetailSurah item
                in rawAllSurahInJuz.reversed.toList()) {
              allSurahInJuz.add(item);
              if (item.name.transliteration.id == awalSurat) {
                break;
              }
            }
            return ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                  'juz': detailJuz,
                  'surah': allSurahInJuz.reversed.toList(),
                });
              },
              leading: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/list.png'),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              title: Text(
                'Juz ${index + 1}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              isThreeLine: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mulai dari ${detailJuz.juzStartInfo}',
                    style: const TextStyle(
                      color: appGrey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    'Sampai ${detailJuz.juzEndInfo}',
                    style: const TextStyle(
                      color: appGrey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
