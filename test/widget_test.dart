import 'dart:convert';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  // INI DARI MODEL SURAH
  Uri url = Uri.parse('https://api.quran.gading.dev/surah');
  var res = await http.get(url);

  // print(res.body);

  // Masuk ke url -> data (as map karena sudah jelas di API nya)
  List data = (json.decode(res.body) as Map<String, dynamic>)['data'];
  // Karena data sudah jelas bentuk list bisa diubah ke bentuk list
  // print(data[113]);

  // data dari API ( raw data ) -> ubah ke model yang sudah disiapkan kita
  Surah surahAnnas = Surah.fromJson(data[113]);

  // print(surahAnnas.name.long);
  // print(surahAnnas.number);
  // print(surahAnnas.numberOfVerses);
  // print(surahAnnas.revelation);
  // print(surahAnnas.sequence);
  // print(surahAnnas.tafsir);

  // INI MASUK KE NESTED MODEL (DETAIL SURAH)
  Uri urlAlIkhlas = Uri.parse('https://api.quran.gading.dev/surah/112');
  var resAlIkhlas = await http.get(urlAlIkhlas);

  // Masih string ubah ke bentuk map dynamic dan ambil data dan simpan ke sebuah variabel
  // print(resAlIkhlas.body);

  Map<String, dynamic> dataAlIkhlas =
      (json.decode(resAlIkhlas.body) as Map<String, dynamic>)['data'];

  // data dari API ( raw data ) -> ubah ke model yang sudah disiapkan kita
  DetailSurah alIkhlas = DetailSurah.fromJson(dataAlIkhlas);

  // print(alIkhlas.name.translation.id);

  // masuk detail alikhlass.ayat ke (0,1,2,3) ambil text lalu arabnya
  print(alIkhlas.verses[0].text.arab);
}
