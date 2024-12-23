import 'package:festit_invited/modules/guest_confirmation/widgets/body_guest_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import './guest_confirmation_controller.dart';

class GuestConfirmationPage extends GetView<GuestConfirmationController> {
  const GuestConfirmationPage({super.key});

  static const String route = '/resposta-do-convidado';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: BodyGuestConfirmation(),
    );
  }
}
