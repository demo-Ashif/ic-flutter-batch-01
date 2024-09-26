import 'package:get/get.dart';
import 'package:swift_shop/features/auth/presentation/controllers/auth_controller.dart';
import 'package:swift_shop/features/cart/presentation/controller/cart_controller.dart';
import 'package:swift_shop/features/categories/presentation/controllers/category_controller.dart';
import 'package:swift_shop/features/products/presentation/controller/product_controller.dart';
import 'package:swift_shop/features/profile/presentation/controller/profile_controller.dart';
import 'package:swift_shop/features/wishlist/presentation/controller/wishlist_controller.dart';

import 'core/di/injection_container.dart';
import 'features/products/presentation/controller/selected_category_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(sl()));
    Get.put(CategoryController(sl()));
    Get.put(ProductController(sl()));
    Get.put(CartController(sl()));
    Get.put(ProfileController(sl()));
    Get.put(WishlistController(sl()));
    Get.put(SelectedCategoryController());
  }
}
