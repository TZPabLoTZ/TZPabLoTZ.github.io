import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  static const route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Container(),
    );
  }
}
