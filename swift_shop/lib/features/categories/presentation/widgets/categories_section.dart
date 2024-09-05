import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/core/utils/core_utils.dart';
import 'package:swift_shop/features/categories/presentation/controllers/category_controller.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();

    CoreUtils.postFrameCall(() {
      _categoryController.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: GetBuilder<CategoryController>(builder: (controller) {
        if (controller.isLoading.value==true) {
          return const Center(child: CircularProgressIndicator()); // Show circular progress when loading
        }

        final categoryList = controller.categoriesList.value ?? [];

        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 31,
                    backgroundColor: Colours.lightThemeSecondaryTextColour,
                    backgroundImage:
                        NetworkImage('${NetworkConstants.imageBaseUrl}/${categoryList[index].image}'),
                  ),
                  const Gap(3),
                  Text(
                    '${categoryList[index].name}',
                    style: TextStyles.paragraphSubTextRegular1
                        .adaptiveColour(context),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const Gap(20),
          itemCount: categoryList.length,
        );
      }),
    );
  }
}
