// search_controller.dart
import 'package:appbaru/app/modules/home/controllers/search_controller.dart';
import 'package:flutter/material.dart';

class SearchController {
  String query = '';

  void updateQuery(String newQuery) {
    query = newQuery;
  }
}
