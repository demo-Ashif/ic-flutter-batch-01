import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/utils/core_utils.dart';
import '../controller/cart_controller.dart';
import 'checkout_successful_view.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({required this.sessionUrl, super.key});

  final String sessionUrl;

  static const path = '/checkout';

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late WebViewController controller;
  final loadingNotifier = ValueNotifier(false);

  // Initialize CartController using GetX
  final CartController cartController = Get.find<CartController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colours.lightThemeTintStockColour)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            CoreUtils.postFrameCall(() {
              loadingNotifier.value = true;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            CoreUtils.postFrameCall(() {
              loadingNotifier.value = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.errorType.toString());
            CoreUtils.showSnackBar(
              context,
              message: '${error.errorCode} Error: ${error.description}',
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            // Handle URL navigation
            if (request.url.startsWith('https://dbestech.biz/payment-success')) {
              final userId = sl<CacheHelper>().getUserId();
              // Use GetX CartController to refresh cart data
              cartController.fetchCart('$userId');
              cartController.fetchCartCount('$userId');

              // Navigate to the checkout success screen using GetX
              Get.offNamed(CheckoutSuccessfulView.path);
              return NavigationDecision.prevent;
            } else if (request.url.startsWith('https://dbestech.biz/cart')) {
              Get.back();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.sessionUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (context, isLoading, __) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colours.lightThemePrimaryColour,
                ),
              );
            }
            return WebViewWidget(controller: controller);
          },
        ),
      ),
    );
  }
}
