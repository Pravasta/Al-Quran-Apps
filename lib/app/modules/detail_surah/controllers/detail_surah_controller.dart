import 'dart:convert';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
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

  void playAudio(String? url) async {
    if (url != null) {
      // proses
      // Catching errors at load time
      try {
        await player.setUrl(url);
        await player.play();
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
