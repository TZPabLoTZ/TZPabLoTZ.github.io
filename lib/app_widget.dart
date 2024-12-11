import 'package:festit_invited/modules/receive_guest/receive_guest_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Festit-convite',
      getPages: AppRoutes.pages,
      initialRoute: ReceiveGuestPage.route,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // defaultTransition: Transition.noTransition, //TODO: Perguntar para o Ailton dps de pronto as telas de acordo com o figma
    );
  }
}
