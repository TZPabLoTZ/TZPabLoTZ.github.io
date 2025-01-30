import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import '../splash/splash_page.dart';
import 'receive_guest_controller.dart';
import 'widgets/body_receive_guest.dart';

class ReceiveGuestPage extends GetView<ReceiveGuestController> {
  static const route = '/r_c/:id';

  const ReceiveGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<ReceiveGuestController>(
        init: ReceiveGuestController(),
        builder: (controller) {
          if (controller.isLoadingScreen) {
            return const SplashPage();
          }
          return const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: BodyReceiveGuest(),
          );
        },
      ),
    );
  }
}
