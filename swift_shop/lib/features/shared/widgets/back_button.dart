import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // if (context.canPop()) context.pop();
        Navigator.pop(context);
      },
      icon: Icon(
        switch (Theme.of(context).platform) {
          TargetPlatform.android ||
          TargetPlatform.fuchsia ||
          TargetPlatform.linux ||
          TargetPlatform.windows =>
            Icons.arrow_back,
          TargetPlatform.iOS ||
          TargetPlatform.macOS =>
            Icons.arrow_back_ios_new,
        },
      ),
    );
  }
}
