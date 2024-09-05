import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../products/presentation/screens/search_view.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButton(
        onPressed: () => Get.toNamed(SearchView.path),
        icon: const Icon(IconlyBroken.search),
      ),
    );
  }
}
