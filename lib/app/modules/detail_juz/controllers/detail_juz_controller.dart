import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/juz.dart';

class DetailJuzController extends GetxController {
  RxInt test = 0.obs;

  // Mengatur Play Stop Resume audio
  // RxString kondisiAudio = 'stop'.obs;
  // Pindah kan ke model agar dapat di play satu satu

  // untuk menyimpan LasPlay audio - Nilai awal null
  Verse? lastVerse;

  // Jembatan audio player dari package
  final player = AudioPlayer();

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
