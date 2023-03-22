import 'dart:convert';

import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {
  // Mengatur Play Stop Resume audio
  // RxString kondisiAudio = 'stop'.obs;
  // Pindah kan ke model agar dapat di play satu satu

  // untuk menyimpan LasPlay audio - Nilai awal null
  Verse? lastVerse;

  // Panggil database
  DatabaseManager database = DatabaseManager.instance;

  // Void bookmark
  void addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    // ambil database
    Database db = await database.db;

    // Apakah isi pertama = false
    bool flagExist = false;

    // Mengatasi tumpukan last_read yang salah
    if (lastRead == true) {
      await db.delete('bookmark', where: 'last_read = 1');
    } else {
      List checkData = await db.query(
        'bookmark',
        where:
            'surah = "${surah.name.transliteration.id}" and ayat = ${ayat.number.inSurah} and juz = ${ayat.meta.juz} and via = "surah" and index_ayat = $indexAyat and last_read = 0',
      );
      print('DIJALANKAN');
      print(checkData);
      // Jika checkdata != 0 maka ada datanyaa yang udh di bookmark / last read
      if (checkData.isNotEmpty) {
        // Ada data - kalau ada berarti flagExist diubah ke true
        flagExist = true;
      }
    }
    // Lalu putuskan apakah mau dieksekusi lagi atau tidak
    if (flagExist == false) {
      // Simpan ke tabble bookmark dan value nya sesuai data yang ada di database manager kita
      await db.insert(
        'bookmark',
        {
          // id sudah jelas bakal incemeetn sendiri
          // Dibawahnya ambil dari lemparan data dari view
          'surah': '${surah.name.transliteration.id}',
          'ayat': ayat.number.inSurah,
          'juz': ayat.meta.juz,
          'via': 'surah',
          'index_ayat': indexAyat,
          // Kalau lastreaad nya true, pilih angka 1 kalau tidak angka 0
          'last_read': lastRead == true ? 1 : 0,
        },
      );

      // Tutup dialog nya
      Get.back();
      // dan tampilkan snackbar
      Get.snackbar('Berhasil', 'Berhasil menambahkan bookmark',
          colorText: Colors.white);
    } else {
      Get.back();
      // dan tampilkan snackbar
      Get.snackbar('Terjadi kesalahaan', 'Bookmark sudah ada',
          colorText: Colors.white);
    }

    // coba print data apkah masuk
    var data = await db.query('bookmark');
    // query itu selecr ftom database nya
    print(data);
  }

  // Jembatan audio player dari package
  final player = AudioPlayer();
  Future<DetailSurah> getDetailSurah(String id) async {
    // INI DARI MODEL DETAIL SURAH
    Uri url = Uri.parse('https://api.quran.gading.dev/surah/$id');
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];

    return DetailSurah.fromJson(data);
  }

  void resumeAudio(Verse ayat) async {
    try {
      // kondisi awal stop lalu ubah ke playing, Kemudian ubah ke stop lagi saat selesai
      ayat.kondisiAudio = 'playing';
      update();
      await player.play();
      ayat.kondisiAudio = 'stop';
      update();
      //
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: "Error code: ${e.code} || Error message: ${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Connection aborted: ${e.message}',
      );
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Tidak dapat resume audio',
      );
    }
  }

  void stopAudio(Verse ayat) async {
    try {
      // Yaudah mengubah state apapun menjadi stop, Kemudian ubah value kondisi ke stop agar icon button di view bisa berubah
      await player.stop();
      ayat.kondisiAudio = 'stop';
      update();
      //
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: "Error code: ${e.code} || Error message: ${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Connection aborted: ${e.message}',
      );
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Tidak dapat stop audio',
      );
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = 'pause';
      update();
      //
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: "Error code: ${e.code} || Error message: ${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Connection aborted: ${e.message}',
      );
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Tidak dapat pause audio',
      );
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio.primary != null) {
      // proses
      // Catching errors at load time
      try {
        //Mencegah terjadinya tumpukan audio berjalan
        lastVerse ??=
            ayat; //(Jika lastverse masih null, masukkan ayat yang di play pertama x)
        // Jika tidak null maka stop dulu yang last verse terakhirnya
        lastVerse!.kondisiAudio == 'stop';
        // Kemudian tambahkan verse yang di klik terbaru
        lastVerse = ayat;
        // Setelah ganti kita juga harus menstop ayat sebelumnya
        lastVerse!.kondisiAudio == 'stop';
        update();
        // BATAS MENCEGAH TERJADINYA ERROR
        await player.setUrl(ayat!.audio.primary);
        await player.stop(); //Jaga jaga kalau ada error
        // ubah value kondisi ke playing
        ayat.kondisiAudio = 'playing';
        update();
        await player.play();
        // kalau sudah selesai kembalikan ke mode stop lagi
        ayat.kondisiAudio = 'stop';
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: "Error code: ${e.code} || Error message: ${e.message}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Connection aborted: ${e.message}',
        );
      } catch (e) {
        // Fallback for all other errors
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'An error occured: $e',
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'URL audio tidak valid',
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
