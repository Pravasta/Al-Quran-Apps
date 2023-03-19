import 'dart:convert';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:alquran/app/data/models/juz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  // Buat untuk menampung List dan digunakan membandingkan Surah dalam Juz
  List<DetailSurah> allSurah = [];
  RxBool isDark = false.obs;
  Future<List<DetailSurah>> getAlSurah() async {
    // INI DARI MODEL SURAH
    Uri url = Uri.parse('https://api.quran.gading.dev/surah');
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)['data'];

    // Karena data masi berbentuk list dynamic maka ubah ke bentuk List Map

    if (data == null || data.isEmpty) {
      return [];
    } else {
      // isi all surah diatas akan berubah menjadi dari sini
      allSurah = data.map((e) => DetailSurah.fromJson(e)).toList();
      return allSurah;
    }
  }

  // KALAU PAKAI INI MASI ERROR DAN BELUM KTMU SOLUSI NYA
  Future<List<Juz>> getAllJuz() async {
    List<Juz> listJuz = [];
    // Lopping untuk meng Get semua data
    for (var i = 1; i <= 30; i++) {
      // INI DARI MODEL SURAH
      Uri url = Uri.parse('https://api.quran.gading.dev/juz/$i');
      var res = await http.get(url);

      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)['data'];

      // Karena data masi berbentuk list dynamic maka ubah ke bentuk List Map

      Juz juz = Juz.fromJson(data);
      listJuz.add(juz);
    }
    return listJuz;
  }

  // Future<List<Map<String, dynamic>>> getAllJuz() async {
  //   int juz = 1;

  //   // List untuk menampung ayat
  //   List<Map<String, dynamic>> penampungAyat = [];
  //   // Penampung all juz
  //   List<Map<String, dynamic>> allJuz = [];

  //   // Lakukan looping tiap surah dalam alquran lalu tambahkan ke variabel penampung sesuai juz nya

  //   for (var i = 1; i <= 114; i++) {
  //     var res =
  //         await http.get(Uri.parse('https://api.quran.gading.dev/surah/$i'));
  //     Map<String, dynamic> rawData = json.decode(res.body)['data'];
  //     DetailSurah data = DetailSurah.fromJson(rawData);

  //     // Baru cek apakah ayat nya null ?
  //     if (data.verses != null) {
  //       // jika tidak lakukan looping didalam ayat pada data tersebut
  //       data.verses?.forEach(
  //         (ayat) {
  //           // Cek jika juz dalam ayat tersebut sudah sama dengan juz, maka tambahkan surah dan ayat yang ada pada looping an

  //           if (ayat.meta.juz == juz) {
  //             penampungAyat.add({
  //               'surah': data,
  //               'ayat': ayat,
  //             });
  //             // kalau sudah diluar juz yang sama maka
  //           } else {
  //             // Jika sudah tambahkan ke dalam tampungan semua juzz
  //             allJuz.add({
  //               'juz': juz,
  //               'start': penampungAyat[0],
  //               'end': penampungAyat[penampungAyat.length - 1],
  //               'verses': penampungAyat,
  //             });
  //             // Kalau sudah juzz nya diincrement
  //             juz++;
  //             // Jangan lupa di clear agar mulai kosong lagi di juz selanjutnya
  //             // penampungAyat.clear();
  //             penampungAyat = [];
  //             // Kenapa tdak clear ? karena clear menghapus semua object
  //             penampungAyat.add(
  //               {
  //                 'surah': data,
  //                 'ayat': ayat,
  //               },
  //             );
  //           }
  //         },
  //       );
  //     }
  //   }
  //   allJuz.add(
  //     {
  //       'juz': juz,
  //       'start': penampungAyat[0],
  //       'end': penampungAyat[penampungAyat.length - 1],
  //       'verses': penampungAyat,
  //     },
  //   );
  //   return allJuz;
  // }
}
