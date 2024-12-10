import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './guest_confirmation_controller.dart';

class GuestConfirmationPage extends GetView<GuestConfirmationController> {
  const GuestConfirmationPage({super.key});

  static const route = '/confirmação_do_convidado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação do convidado'),
      ),
      body: Container(),
    );
  }
}
