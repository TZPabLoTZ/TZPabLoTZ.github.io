import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/event_details_card.dart';
import '../../../widgets/text_default.dart';

class BodyGuestConfirmation extends StatelessWidget {
  const BodyGuestConfirmation({super.key});

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
            Column(
              children: [
                Image.asset(
                  'assets/images/checked.png',
                  scale: 1,
                  height: 150,
                ),
                const TextDefault(
                  text: 'Resposta enviada!',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.purple,
                ),
                const SizedBox(height: 12),
                const TextDefault(
                  text:
                      'Caso deseje alterar sua resposta, entre em\n contato com quem enviou o convite para você.',
                  fontSize: 16,
                  maxLines: 2,
                  fontWeight: FontWeight.w300,
                  color: AppColors.text,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Image.asset(
                'assets/images/link.png',
                scale: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
