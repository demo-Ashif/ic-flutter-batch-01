import 'package:get/get.dart';
import 'package:swift_shop/core/router/app_router.dart';
import 'package:swift_shop/features/cart/presentation/views/cart_view.dart';
import 'package:swift_shop/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:swift_shop/features/products/presentation/screens/product_detail_screen.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/views/onboarding_screen.dart';

class GetAppRouter{
  List<GetPage> getRoutes(){
    return [
      GetPage(
        name: AppRoutes.initial,
        page: () => const SplashScreen(),
        // Bindings for the splash screen if necessary
      ),
      GetPage(
        name: AppRoutes.onboardingScreen,
        page: () => const OnBoardingScreen(),
        // Bindings for the onboarding screen if necessary
      ),
      GetPage(
        name: AppRoutes.homeScreen,
        page: () => const HomeScreen(),
        // Bindings for the onboarding screen if necessary
      ),

      GetPage(
        name: AppRoutes.loginScreen,
        page: () => const LoginScreen(),
        // Bindings for the onboarding screen if necessary
      ),

      GetPage(
        name: AppRoutes.registerScreen,
        page: () => const RegisterScreen(),
        // Bindings for the onboarding screen if necessary
      ),
      GetPage(
        name: AppRoutes.dashboardScreen,
        page: () => const DashboardScreen(),
        // Bindings for the onboarding screen if necessary
      ),
      GetPage(
        name: AppRoutes.productDetailScreen,
        page: () {
          final productId = Get.parameters['productId']; // Retrieve the productId from the URL
          return ProductDetailsScreen(productId!);
        },
        // Bindings for the onboarding screen if necessary
      ),
      GetPage(
        name: AppRoutes.cartProductScreen,
        page: () => const CartProductScreen(),
        // Bindings for the onboarding screen if necessary
      ),
    ];
  }
}