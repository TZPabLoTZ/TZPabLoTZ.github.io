import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/text_default.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      child: const Column(
        children: [
          SizedBox(height: 80),
          TextDefault(
            text: 'Aniversário da Sofia',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
          ),
          TextDefault(
            text: '20/04/2025 às 16h',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 20),
          TextDefault(
            text: 'Condomínio Bela Vista Rua 12 Casa 09',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 45),
        ],
      ),
    );
  }
}
