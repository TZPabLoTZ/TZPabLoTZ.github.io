import 'package:festit_invited/modules/receive_guest/receive_guest_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/text_default.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiveGuestController>(
      builder: (contol) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.purple,
            border: Border(
              bottom: BorderSide(
                color: AppColors.orange,
                width: 2,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 80),
              TextDefault(
                // text: 'Aniversário da Sofia',
                text: contol.evento?.nome ?? 'Sem dados',
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textSecondary,
              ),
              TextDefault(
                // text: '20/04/2025 às 16h',
                text: contol.evento?.data.toString() ?? 'Sem dados',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 20),
              TextDefault(
                // text: 'Condomínio Bela Vista Rua 12 Casa 09',
                text: contol.evento?.endereco ?? 'Sem dados',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 45),
            ],
          ),
        );
      },
    );
  }
}
