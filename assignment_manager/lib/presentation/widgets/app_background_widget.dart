import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/asset_manager.dart';

class AppBackgroundWidget extends StatelessWidget {
  final Widget child;

  const AppBackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetManager.appBackgroundImage,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
