import 'package:flutter/material.dart';

import '../../../widgets/event_details_card.dart';
import 'guest_form.dart';

class BodyReceiveGuest extends StatelessWidget {
  const BodyReceiveGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const EventDetailsCard(),
            const GuestForm(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/images/link.png',
                  scale: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
