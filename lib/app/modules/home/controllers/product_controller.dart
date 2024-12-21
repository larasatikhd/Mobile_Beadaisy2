// product_detail_controller.dart

import 'package:flutter/material.dart';

class ProductDetailController {
  String selectedSize = 'S';
  Color selectedColor = Colors.brown[200]!;

  void setSize(String size) {
    selectedSize = size;
  }

  void setColor(Color color) {
    selectedColor = color;
  }
}
