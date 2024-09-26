import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../controller/selected_category_controller.dart';
import '../controller/product_controller.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    required this.onSelected,
    required this.selectedCategory,
    super.key,
    this.popWhenEmpty = false,
  });

  final bool popWhenEmpty;
  final ValueChanged<ProductCategoryModel> onSelected;
  final ProductCategoryModel selectedCategory;

  @override
  State createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final SelectedCategoryController selectedCategoryController = Get.find<SelectedCategoryController>();
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchCategories(); // Fetch categories using GetX controller
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const LinearProgressIndicator();
        } else if (controller.categories.isNotEmpty) {
          return SizedBox(
            height: 40,
            child: Theme(
              data: context.theme.copyWith(canvasColor: Colors.transparent),
              child: ListView.separated(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    final selected = widget.selectedCategory.name!.toLowerCase() == 'all';
                    return ChoiceChip(
                      label: const Text('All'),
                      labelStyle: selected
                          ? TextStyles.headingSemiBold1.white
                          : TextStyles.paragraphSubTextRegular1.grey,
                      selected: selected,
                      selectedColor: Colours.lightThemePrimaryColour,
                      showCheckmark: false,
                      backgroundColor: Colors.transparent,
                      onSelected: (_) {
                        widget.onSelected(const ProductCategoryModel.all());
                      },
                    );
                  }
                  final category = controller.categories[index - 1];
                  final selected = widget.selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category.name!),
                    labelStyle: selected
                        ? TextStyles.headingSemiBold1.white
                        : TextStyles.paragraphSubTextRegular1.grey,
                    selected: selected,
                    selectedColor: Colours.lightThemePrimaryColour,
                    showCheckmark: false,
                    backgroundColor: Colors.transparent,
                    onSelected: (_) {
                      widget.onSelected(category);
                    },
                  );
                },
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
