import 'dart:js' as js;

import 'package:flutter/material.dart';

class ImagesLink extends StatelessWidget {
  const ImagesLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 12),
      child: Column(
        spacing: 12,
        children: [
          Image.asset(
            'assets/images/logo.png',
            scale: 2.6,
          ),
          const Column(
            children: [
              Text(
                'Vai organizar uma festa?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Text(
                'Baixe agora o app gratuito!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              GestureDetector(
                onTap: () {
                  openUrlInSamePage(
                      'https://play.google.com/store/apps/details?id=br.com.festit.app');
                },
                child: Image.asset(
                  'assets/images/google_play.png',
                  scale: 2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  openUrlInSamePage(
                      'https://apps.apple.com/br/app/festit/id1561644396?platform=iphone');
                },
                child: Image.asset(
                  'assets/images/app_store.png',
                  scale: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void openUrlInSamePage(String url) {
  js.context.callMethod('eval', ['window.location.href="$url";']);
}
