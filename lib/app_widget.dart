import 'package:festit_invited/modules/receive_guest/receive_guest_controller.dart';
import 'package:festit_invited/modules/receive_guest/receive_guest_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // setUrlStrategy(PathUrlStrategy());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Festit-convite',
      getPages: AppRoutes.pages,
      initialRoute: ReceiveGuestPage.route,
      initialBinding: BindingsBuilder(() {
        Get.put(ReceiveGuestController());
      }),
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
