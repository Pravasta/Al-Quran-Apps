import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SearchPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
