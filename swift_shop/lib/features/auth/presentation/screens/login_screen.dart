import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/res/styles/colors.dart';
import 'package:swift_shop/features/shared/widgets/app_bar_bottom.dart';

import '../../../../core/res/styles/text.dart';
import '../widgets/login_form.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyles.headingSemiBold,
        ),
        bottom: AppBarBottom(),
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 30),
            children: [
              Text(
                'Hello!!',
                style: TextStyles.headingBold3.adaptiveColour(context),
              ),
              Text(
                'Sign in with your account details',
                style: TextStyles.paragraphSubTextRegular1.grey,
              ),
              const Gap(40),
              //login form
              LoginForm()
            ],
          ),),
          Gap(8),
          RichText(
            text: TextSpan(
              text: "Don't have an account?",
              style: TextStyles.paragraphSubTextRegular3.grey,
              children: [
                TextSpan(
                  text: 'Create Account',
                  style: const TextStyle(color: Colours.lightThemePrimaryColour),
                  recognizer: TapGestureRecognizer()..onTap=(){
                    // context.go(RegisterScreen.path);
                    Get.to(()=>const RegisterScreen());
                  }
                ),
              ]
            ),
          ),
          Gap(16),
        ],
      ),
    );
  }
}
