import 'package:festit_invited/modules/guest_confirmation/guest_confirmation_page.dart';
import 'package:festit_invited/modules/receive_guest/receive_guest_page.dart';
import 'package:festit_invited/modules/splash/splash_page.dart';
import 'package:get/get.dart';

import 'modules/receive_guest/receive_guest_controller.dart';

class AppRoutes {
  AppRoutes._();

  static List<GetPage> pages = [
    GetPage(
      name: SplashPage.route,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: ReceiveGuestPage.route,
      page: () => const ReceiveGuestPage(),
      binding: BindingsBuilder.put(() => ReceiveGuestController()),
    ),
    GetPage(
      name: GuestConfirmationPage.route,
      page: () => const GuestConfirmationPage(),
    ),
  ];
}
