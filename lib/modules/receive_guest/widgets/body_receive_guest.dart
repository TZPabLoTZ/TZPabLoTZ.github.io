import 'dart:js' as js;

import 'package:flutter/material.dart';

import '../../../widgets/event_details_card.dart';
import 'guest_form.dart';

class BodyReceiveGuest extends StatelessWidget {
  const BodyReceiveGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const EventDetailsCard(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const GuestForm(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 12),
            child: GestureDetector(
              onTap: () {
                openUrlInSamePage(
                    'https://play.google.com/store/apps/details?id=br.com.festit.app');
              },
              child: Image.asset(
                'assets/images/link.png',
                scale: 3.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void openUrlInSamePage(String url) {
  js.context.callMethod('eval', ['window.location.href="$url";']);
}
