import 'package:get/get.dart';

import '../../../../core/utils/enums/gender_age_category_enum.dart';

class GenderAgeCategoryController extends GetxController {
  // Initialize the category with `GenderAgeCategory.all`
  var selectedCategory = GenderAgeCategory.all.obs;

  // Method to change the category
  void changeCategory(GenderAgeCategory category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      update(); // Notify listeners to rebuild UI
    }
  }
}
