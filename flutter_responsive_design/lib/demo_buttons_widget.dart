import 'package:flutter/material.dart';

class DemoButtonWidget extends StatefulWidget {
  const DemoButtonWidget({super.key});

  @override
  State<DemoButtonWidget> createState() => _DemoButtonWidgetState();
}

class _DemoButtonWidgetState extends State<DemoButtonWidget> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    print('DemoButton BUILD called');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
