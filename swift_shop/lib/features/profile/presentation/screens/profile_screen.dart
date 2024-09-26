import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/profile/presentation/controller/profile_controller.dart';

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../../core/utils/core_utils.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../widgets/profile_form.dart';
import '../widgets/update_user_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const path = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameFocusNode = FocusNode();
  final nameNotifier = ValueNotifier('');
  final changeNotifier = ValueNotifier(false);
  final updateContainer = <String, dynamic>{};
  final authUserAdapterFamilyKey = GlobalKey();

  /// If this page is locked for editing
  final lockNotifier = ValueNotifier(true);

  final ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final userId = sl<CacheHelper>().getUserId();
    await controller.fetchUser('$userId');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            bottom: const AppBarBottom(),
            actions: [
              ValueListenableBuilder(
                valueListenable: lockNotifier,
                builder: (_, isLocked, __) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        lockNotifier.value = !lockNotifier.value;
                        if (!lockNotifier.value) {
                          nameFocusNode.requestFocus();
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        final message = lockNotifier.value
                            ? 'Profile Locked'
                            : 'Profile Unlocked';
                        CoreUtils.showSnackBar(context, message: message);
                      },
                      icon: Icon(
                          isLocked ? IconlyBroken.edit : IconlyBroken.lock),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colours.lightThemePrimaryColour,
                      child: Center(
                        child: Text(
                          controller.user.value.name,
                          textAlign: TextAlign.center,
                          style: TextStyles.headingMedium.white,
                        ),
                      ),
                    ),
                    const Gap(15),
                    Text(
                      controller.user.value.name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.headingMedium.adaptiveColour(context),
                    ),
                    const Gap(20),
                    Expanded(
                      flex: 2,
                      child: AbsorbPointer(
                        absorbing: lockNotifier.value,
                        child: ProfileForm(
                          nameNotifier: nameNotifier,
                          nameFocusNode: nameFocusNode,
                          changeNotifier: changeNotifier,
                          updateContainer: updateContainer,
                        ),
                      ),
                    ),
                    if (changeNotifier.value)
                      UpdateUserButton(
                        changeNotifier: changeNotifier,
                        authUserAdapterFamilyKey: authUserAdapterFamilyKey,
                        onPressed: () {
                          controller.updateUser('user-id', updateContainer);
                          lockNotifier.value = true;
                        },
                        updateData: updateContainer,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
