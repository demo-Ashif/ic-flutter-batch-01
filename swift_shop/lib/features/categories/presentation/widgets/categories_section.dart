import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/core/utils/core_utils.dart';
import 'package:swift_shop/features/categories/presentation/controllers/category_controller.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    // Fetch categories using GetX Controller
    CoreUtils.postFrameCall(() => categoryController.getCategories());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colours.lightThemePrimaryColour,
            ),
          );
        } else if (controller.categoriesList.isEmpty) {
          return const Center(
            child: Text('No categories found'),
          );
        } else {
          return SizedBox(
            height: 95,
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoriesList.length,
              separatorBuilder: (_, __) => const Gap(20),
              itemBuilder: (context, index) {
                final category = controller.categoriesList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/${category.name}', arguments: category);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 31,
                        backgroundColor: Colours.lightThemeSecondaryTextColour,
                        backgroundImage: category.image != null
                            ? NetworkImage('${NetworkConstants.imageBaseUrl}/${category.image!}')
                            : null,
                      ),
                      const Gap(3),
                      Text(
                        category.name ?? '',
                        style: TextStyles.paragraphSubTextRegular1
                            .adaptiveColour(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

