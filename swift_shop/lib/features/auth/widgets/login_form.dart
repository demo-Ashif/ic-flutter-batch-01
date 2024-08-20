import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/shared/widgets/rounded_button.dart';

import '../../../core/res/styles/text.dart';
import '../../../core/utils/core_utils.dart';
import '../../shared/widgets/vertical_label_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          VerticalLabelField(
            label: 'Email',
            hintText: 'Enter your email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          Gap(20),
          ValueListenableBuilder(
              valueListenable: obscurePasswordNotifier,
              builder: (_, value, __) {
                return VerticalLabelField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      obscurePasswordNotifier.value =
                          !obscurePasswordNotifier.value;
                    },
                    child: Icon(
                      value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                  obscureText: value,
                );
              }),
          const Gap(20),
          SizedBox(
            width: double.maxFinite,
            child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // context.push(ForgotPasswordScreen.path);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyles.paragraphSubTextRegular1.primary,
                  ),
                )),
          ),
          const Gap(40),
          RoundedButton(
              onPressed: () {
                context.go('/', extra: 'home');
              },
              text: 'Sign In'),
        ],
      ),
    );
  }
}
