import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../../../shared/widgets/empty_data.dart';
import '../../../shared/widgets/menu_icon.dart';
import '../../../shared/widgets/search_button.dart';
import '../controller/wishlist_controller.dart';
import '../widgets/wishlist_product_title.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const path = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController wishlistController = Get.find<WishlistController>();

  Future<void> getUserWishlist() async {
    final userId  = sl<CacheHelper>().getUserId();
    await wishlistController.fetchWishlist('$userId');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: getUserWishlist,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Saved Items'),
              leading: const MenuIcon(),
              bottom: const AppBarBottom(),
              actions: const [SearchButton(padding: EdgeInsets.only(right: 10))],
            ),
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colours.lightThemePrimaryColour,
                      ),
                    );
                  } else if (controller.wishlist.isEmpty) {
                    return const EmptyData('No Saved Products');
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final product = controller.wishlist[index];
                      return WishlistProductTile(product);
                    },
                    separatorBuilder: (_, __) => const Gap(20),
                    itemCount: controller.wishlist.length,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
