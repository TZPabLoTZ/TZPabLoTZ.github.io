import 'package:festit_invited/modules/guest_confirmation/guest_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/save_send_button.dart';
import '../../../widgets/text_default.dart';
import '../receive_guest_controller.dart';
import 'search_field.dart';

class GuestForm extends StatelessWidget {
  const GuestForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: GetBuilder<ReceiveGuestController>(
          builder: (control) {
            return Column(
              children: [
                const SizedBox(height: 18),
                const TextDefault(
                  text: 'Confirme sua presença:',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.purple,
                ),
                const SizedBox(height: 20),
                SearchField(
                  textController: control.guestController,
                  hintText: 'Digite aqui o seu primeiro nome',
                  focusNode: control.guestFocusNode,
                  onPrefix: () {},
                  onChanged: (value) {
                    control.updateSuggestions(value, -1);
                  },
                ),
                const SizedBox(height: 6),
                if (control.isGuestNameComplete()) ...[
                  ...control.guestControllers.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final textController = entry.value;
                      final focusNode = control.guestFocusNodes[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: SearchField(
                          textController: textController,
                          hintText: 'Digite o nome do acompanhante',
                          focusNode: focusNode,
                          onPrefix: () {},
                          onSuffix: () => control.removeCompanionField(index),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                      onTap: control.addCompanionField,
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.purple,
                              radius: 10,
                              child: Icon(
                                Icons.add,
                                size: 14,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Adicionar acompanhante',
                              style: TextStyle(color: AppColors.purple),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SaveButton(
                        title: 'Sim, eu vou! :)',
                        color: AppColors.buttonLogin,
                        onTap: () async {
                          String userId = control.userId!;
                          String convidado =
                              control.guestController.text.trim();
                          String? acompanhante =
                              control.guestControllers.isNotEmpty
                                  ? control.guestControllers.first.text.trim()
                                  : null;

                          bool result = await control.updateGuestStatus(
                            userId,
                            convidado,
                            'Confirmado',
                            acompanhanteNome: acompanhante,
                          );

                          if (result) {
                            Get.offAndToNamed(GuestConfirmationPage.route);
                          } else {
                            Get.snackbar(
                              'Erro',
                              'Erro ao atualizar o status do convidado.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      SaveButton(
                        title: 'Não posso ir :(',
                        color: AppColors.orange,
                        onTap: () async {
                          String userId = control.userId!;
                          String convidado =
                              control.guestController.text.trim();

                          await control.updateGuestStatuspending(
                            userId,
                            convidado,
                            'Ausente',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
