import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/select_categories_dialog.dart';

class CategoryModel {
  final String name;
  final String emoji;

  const CategoryModel({required this.name, required this.emoji});
}

class SelectCategoriesController extends GetxController {
  final selectedCategories = <String>{}.obs;

  final categories = [
    const CategoryModel(name: 'Plumbing', emoji: '💧'),
    const CategoryModel(name: 'Electrical', emoji: '⚡'),
    const CategoryModel(name: 'Ac & HVAC', emoji: '❄️'),
    const CategoryModel(name: 'Painting', emoji: '🎨'),
    const CategoryModel(name: 'Moving', emoji: '🚛'),
    const CategoryModel(name: 'Gardening', emoji: '🌿'),
  ];

  void toggleCategory(String name) {
    if (selectedCategories.contains(name)) {
      selectedCategories.remove(name);
    } else {
      selectedCategories.add(name);
    }
  }

  bool isSelected(String name) => selectedCategories.contains(name);

  void confirm() {
    Get.back(result: selectedCategories.toList());
    // TODO: handle selected categories
  }

  static void show(BuildContext context) {
    Get.put(SelectCategoriesController());
    showDialog(
      context: context,
      builder: (_) => const SelectCategoriesDialog(),
    );
  }
}