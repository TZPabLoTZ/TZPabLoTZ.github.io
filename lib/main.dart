import 'dart:io';

import 'package:festit_invited/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDxa5w3vNHJWWgjU9vc8r446BoPQpDr-xw",
      authDomain: "festit-c0636.firebaseapp.com",
      projectId: "festit-c0636",
      storageBucket: "festit-c0636.appspot.com",
      messagingSenderId: "133375235827",
      appId: "1:133375235827:web:502384859e425e2f17c986",
      measurementId: "G-Q41DKM8WLN",
    ),
  );

  print('NOME DO APP: ${app.name}');

  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppWidget());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (cert, host, port) => true;
}
