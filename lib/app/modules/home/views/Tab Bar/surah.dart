import 'package:alquran/app/constant/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/surah.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';

class SurahTab extends GetView<HomeController> {
  const SurahTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: controller.getAlSurah(),
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
            Surah surah = snapshot.data![index];
            return ListTile(
              onTap: () {
                // Kalau argument ang dikirim berupa surah memang tidak masalah, tpi akan berbeda hasil jika digunakan dalam bookmark
                // Karena dalam API surah tidak lah detail, Sedangkan dalam detail surah sudah detail
                // Jadi bagi bookmark dia tidak akan memiliki parameter lengkap untuk menggunakan scroll to index
                // Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                  'name': surah.name.transliteration!.id,
                  'number': surah.number,
                });
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/list.png'),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${surah.number}',
                  ),
                ),
              ),
              title: Text(
                '${surah.name.transliteration?.id}',
              ),
              subtitle: Text(
                '${surah.numberOfVerses} ayat | ${surah.revelation.id}',
                style: const TextStyle(
                  color: appGrey,
                ),
              ),
              trailing: Text(
                '${surah.name.short}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: appPurpleLight,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
