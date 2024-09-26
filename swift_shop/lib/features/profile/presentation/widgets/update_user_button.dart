import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/extensions/widget_extensions.dart';

import '../../../../core/utils/typedefs.dart';
import '../../../shared/widgets/rounded_button.dart';
import '../controller/profile_controller.dart';

class UpdateUserButton extends StatelessWidget {
  const UpdateUserButton({
    required this.updateData,
    required this.changeNotifier,
    required this.authUserAdapterFamilyKey,
    this.onPressed,
    super.key,
  });

  final ValueNotifier<bool> changeNotifier;
  final Map<String, dynamic> updateData;
  final VoidCallback? onPressed;
  final GlobalKey authUserAdapterFamilyKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GetBuilder<ProfileController>(
        builder: (controller) {
          return RoundedButton(
            height: 50,
            onPressed: (){
               if(!controller.isUpdating.value){
                 onPressed!();
               }
            },
            text: 'Save',
          ).loading(controller.isUpdating.value);
        },
      ),
    );
  }
}