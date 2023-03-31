import 'dart:convert';

import 'package:alquran/app/data/models/detailSurah.dart' as j;

import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.quran.gading.dev/surah');
  var res = await http.get(url);

  List data = json.decode(res.body)['data'];

  print(data);
}

// void main() anc {
//   // INI DARI MODEL SURAH
//   Uri url = Uri.parse('https://api.quran.gading.dev/surah');
//   var res = await http.get(url);

//   // print(res.body);

//   // Masuk ke url -> data (as map karena sudah jelas di API nya)
//   List data = (json.decode(res.body) as Map<String, dynamic>)['data'];
//   // Karena data sudah jelas bentuk list bisa diubah ke bentuk list
//   // print(data[113]);

//   // data dari API ( raw data ) -> ubah ke model yang sudah disiapkan kita
//   Surah surahAnnas = Surah.fromJson(data[113]);

//   // print(surahAnnas.name.long);
//   // print(surahAnnas.number);
//   // print(surahAnnas.numberOfVerses);
//   // print(surahAnnas.revelation);
//   // print(surahAnnas.sequence);
//   // print(surahAnnas.tafsir);

//   // INI MASUK KE NESTED MODEL (DETAIL SURAH)
//   Uri urlAlIkhlas = Uri.parse('https://api.quran.gading.dev/surah/112');
//   var resAlIkhlas = await http.get(urlAlIkhlas);

//   // Masih string ubah ke bentuk map dynamic dan ambil data dan simpan ke sebuah variabel
//   // print(resAlIkhlas.body);

//   Map<String, dynamic> dataAlIkhlas =
//       (json.decode(resAlIkhlas.body) as Map<String, dynamic>)['data'];

//   // data dari API ( raw data ) -> ubah ke model yang sudah disiapkan kita
//   DetailSurah alIkhlas = DetailSurah.fromJson(dataAlIkhlas);

//   // print(alIkhlas.name.translation.id);

//   // masuk detail alikhlass.ayat ke (0,1,2,3) ambil text lalu arabnya
//   // print(alIkhlas.verses[0].text.arab);
//   // print(alIkhlas.preBismillah);

//   // Future<DetailSurah> getDetailSurah(String id) async {
//   //   // INI DARI MODEL DETAIL SURAH
//   //   Uri url = Uri.parse('https://api.quran.gading.dev/surah/$id');
//   //   var res = await http.get(url);

//   //   Map<String, dynamic> data =
//   //       (json.decode(res.body) as Map<String, dynamic>)['data'];
//   //   DetailSurah test = DetailSurah.fromJson(data);
//   //   // print(test);
//   //   return DetailSurah.fromJson(data);
//   // }

//   // await getDetailSurah(1.toString());

//   var ayat = await http.get(Uri.parse('https://api.quran.gading.dev/juz/1'));

//   Map<String, dynamic> dataAyat = json.decode(ayat.body)['data'];
//   // print(dataAyat);

//   // Ambil tanpa surah
//   Map<String, dynamic> dataDetailAyat = {
//     'juz': dataAyat['juz'],
//     'juzStartSurahNumber': dataAyat['juzStartSurahNumber'],
//     'juzEndSurahNumber': dataAyat['juzEndSurahNumber'],
//     'juzStartInfo': dataAyat['juzStartInfo'],
//     'juzEndInfo': dataAyat['juzEndInfo'],
//     'totalVerses': dataAyat['totalVerses'],
//   };
//   // print(dataDetailAyat);

//   // convert map -> model ayat
//   Juz ayatModel = Juz.fromJson(dataDetailAyat);
//   print(ayatModel.juzStartInfo);
// }

// UNTUK TEST KELENGKAPAN AYAT JIKA TERJADI SESUAI DI VIDEO BAK SANDHIKA RAHARDHI (API BELUM LENGKAP) - HARUS DIAKALI
// INI TARGET KITA
/*
  [
    {
      'juz' : ......
      'start': dimulai dari ayat mana
      'end' : berakhir di ayat mana dalam sebuah juz
      'verses' : [
        {
          'ayat' : ayat nya
          'surah' : surah apa yang dimasukkan
        }
      ]
    }
  ]
*/

// void main() async {
//   // Membuat variabel pembanding dari nilaiu utama nya juz 1
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
//     j.DetailSurah data = j.DetailSurah.fromJson(rawData);

//     // Baru cek apakah ayat nya null ?
//     if (data.verses != null) {
//       // jika tidak lakukan looping didalam ayat pada data tersebut
//       data.verses?.forEach((ayat) {
//         // Cek jika juz dalam ayat tersebut sudah sama dengan juz, maka tambahkan surah dan ayat yang ada pada looping an

//         if (ayat.meta.juz == juz) {
//           penampungAyat.add({
//             'surah': data.name.transliteration.id,
//             'ayat': ayat,
//           });
//           // kalau sudah diluar juz yang sama maka
//         } else {
//           print('==================');
//           print('Berhasil Memasukkan JUZ $juz');
//           print('Start :');
//           print(
//               'Ayat : ${(penampungAyat[0]['ayat'] as j.Verse).number.inSurah}');
//           print((penampungAyat[0]['ayat'] as j.Verse).text.arab);
//           print('END :');
//           print(
//               'Ayat ${(penampungAyat[penampungAyat.length - 1]['ayat'] as j.Verse).number.inSurah}');
//           print((penampungAyat[penampungAyat.length - 1]['ayat'] as j.Verse)
//               .text
//               .arab);
//           // Jika sudah tambahkan ke dalam tampungan semua juzz
//           allJuz.add({
//             'juz': juz,
//             'start': penampungAyat[0],
//             'end': penampungAyat[penampungAyat.length - 1],
//             'verses': penampungAyat,
//           });
//           // Kalau sudah juzz nya diincrement
//           juz++;
//           // Jangan lupa di clear agar mulai kosong lagi di juz selanjutnya
//           // penampungAyat.clear();
//           penampungAyat = [];
//           // Kenapa tdak clear ? karena clear menghapus semua object
//           penampungAyat.add({
//             'surah': data.name.transliteration.id,
//             'ayat': ayat,
//           });
//         }
//       });
//     }
//     print('==================');
//     print('Berhasil Memasukkan JUZ $juz');
//     print('Start :');
//     print('Ayat : ${(penampungAyat[0]['ayat'] as j.Verse).number.inSurah}');
//     print((penampungAyat[0]['ayat'] as j.Verse).text.arab);
//     print('END :');
//     print(
//         'Ayat ${(penampungAyat[penampungAyat.length - 1]['ayat'] as j.Verse).number.inSurah}');
//     print(
//         (penampungAyat[penampungAyat.length - 1]['ayat'] as j.Verse).text.arab);
//   }
// }
