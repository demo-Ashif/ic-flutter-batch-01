import 'package:assignment_manager/presentation/controllers/sign_in_controller.dart';
import 'package:assignment_manager/presentation/screens/assignment/bottom_nav_screen.dart';
import 'package:assignment_manager/presentation/widgets/app_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/toast_util.dart';
import 'email_verify_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final result = await _signInController.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    //show message
    if (mounted && result == true) {
      ToastUtil.showSnackBarMessage(context, 'Login Success!');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavScreen(),
          ),
          (route) => false);
    } else {
      //show error message
      if (mounted) {
        ToastUtil.showSnackBarMessage(
          context,
          _signInController.errorMessage,
          isErrorMessage: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AppBackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(100),
                  Text('Let\'s Start with Us!',
                      style: theme.textTheme.titleLarge),
                  const Gap(16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: 'Enter your email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: 'Enter your password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const Gap(24),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SignInController>(builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signIn();
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                      );
                    }),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmailVerifyScreen(),
                          ),
                        );
                      },
                      child: const Text('Forgot Password?')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text('Sign Up')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
