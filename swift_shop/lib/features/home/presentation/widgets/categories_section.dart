import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  void initState() {
    //get categories
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 31,
                  backgroundColor: Colours.lightThemeSecondaryTextColour,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1542291026-7eec264c27ff'),
                ),
                const Gap(3),
                Text('Cat ${index+1}', style: TextStyles.paragraphSubTextRegular1
                    .adaptiveColour(context),),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const Gap(20),
        itemCount: 5,
      ),
    );
  }
}
