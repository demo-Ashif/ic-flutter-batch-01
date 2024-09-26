import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/res/media.dart';
import '../../../../core/res/styles/text.dart';
import '../../../dashboard/presentation/controller/navigation_controller.dart';
import '../../../shared/widgets/rounded_button.dart';

class CheckoutSuccessfulView extends ConsumerWidget {
  const CheckoutSuccessfulView({super.key});

  static const path = '/checkout-completed';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Media.checkMark, repeat: false),
            Text(
              'Your order has been placed',
              textAlign: TextAlign.center,
              style:
                  TextStyles.buttonTextHeadingSemiBold.adaptiveColour(context),
            ),
            const Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundedButton(
                height: 50,
                onPressed: () {
                  ref
                      .read(navigationControllerProvider.notifier)
                      .changeIndex(0);
                  Get.toNamed('/', arguments: 'home');
                },
                text: 'Continue Shopping   🛒',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
