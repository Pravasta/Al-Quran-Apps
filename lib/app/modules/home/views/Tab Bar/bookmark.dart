import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkClass extends StatelessWidget {
  const BookmarkClass({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: c.getBookmark(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Cek dulu jika db kosong maka
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Bookmark masih kosong',
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data![index];
                return ListTile(
                  onTap: () => print(data),
                  leading: Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/list.png'),
                      ),
                    ),
                    child: Center(child: Text('${index + 1}')),
                  ),
                  title: Text(
                    '${data['surah']}',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  subtitle: Text(
                    'Ayat ${data['ayat']} - via ${data['via']}',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
