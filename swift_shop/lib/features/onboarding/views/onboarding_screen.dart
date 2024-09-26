import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../core/app/cache/cache_helper.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/res/media.dart';
import '../../../core/res/styles/colors.dart';
import '../../../core/res/styles/text.dart';
import '../../../core/utils/core_utils.dart';
import '../../auth/presentation/screens/login_screen.dart';
import '../../shared/widgets/rounded_button.dart'; // Ensure you have go_router added to your dependencies

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const path = '/onboarding-screen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  void _goToNextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void _goToLoginScreen() {
    sl<CacheHelper>().cacheFirstTimer();
    Get.toNamed(LoginScreen.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PageView(
            controller: _pageController,
            children: [
              _buildFirstPage(context),
              _buildSecondPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPage(BuildContext context) {
    final adaptiveColour = CoreUtils.adaptiveColour(
      context,
      darkModeColour: Colors.white,
      lightModeColour: Colours.lightThemePrimaryTextColour,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Media.onBoardingFemale,
              height: 380,
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: '2024\n',
                style: TextStyles.headingBold.orange,
                // Assuming this is a defined text style
                children: [
                  TextSpan(
                    text: 'Winter Sale is Live now.',
                    style: TextStyle(color: adaptiveColour),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: RoundedButton(
            text: 'Next',
            onPressed: _goToNextPage,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondPage(BuildContext context) {
    final adaptiveColour = CoreUtils.adaptiveColour(
      context,
      darkModeColour: Colors.white,
      lightModeColour: Colours.lightThemePrimaryTextColour,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Media.onBoardingMale,
              height: 380,
            ),
            // Update the image path as needed
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: 'Flash Sale\n',
                style: TextStyles.headingBold.copyWith(color: adaptiveColour),
                children: [
                  const TextSpan(
                    text: "Men's ",
                    style: TextStyle(color: Colours.lightThemeSecondaryColour),
                  ),
                  TextSpan(
                    text: 'Shirts & Watches',
                    style: TextStyle(color: adaptiveColour),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: RoundedButton(
            text: 'Get Started',
            onPressed: _goToLoginScreen,
          ),
        ),
      ],
    );
  }
}
