import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import 'receive_guest_controller.dart';
import 'widgets/body_receive_guest.dart';

class ReceiveGuestPage extends GetView<ReceiveGuestController> {
  const ReceiveGuestPage({super.key});

  static const route = '/receber_convidado';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: BodyReceiveGuest(),
    );
  }
}
