import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/evento.dart';
import '../../infra/repositories/evento_repository.dart';

class ReceiveGuestController extends GetxController {
  final repository = EventoRepository();

  final guestController = TextEditingController();
  final guestFocusNode = FocusNode();

  final List<TextEditingController> companionControllers = [];
  final List<FocusNode> companionFocusNodes = [];

  final List<String> filteredSuggestions = [];
  final List<String> usedNames = [];

  bool showSuggestions = false;

  Evento? evento;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchEvento();
  }

  Future<void> fetchEvento() async {
    try {
      isLoading = true;
      update();
      final userId = Get.parameters['id'] ?? '';
      if (userId.isEmpty) {
        throw Exception('ID do usuário não encontrado');
      }

      final eventos = await repository.getEventosByUserId(userId);
      if (eventos.isNotEmpty) {
        evento = eventos.first;
      } else {
        evento = null;
      }
    } catch (e) {
      print('Erro ao buscar evento: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  final List<String> listaTags = [
    'Carlos',
    'Ana',
    'Annabelle',
    'Maria',
    'João',
    'Pedro',
    'Julia',
  ];

  void addCompanionField() {
    companionControllers.add(TextEditingController());
    companionFocusNodes.add(FocusNode());
    update();
  }

  void removeCompanionField(int index) {
    if (index >= 0 && index < companionControllers.length) {
      companionControllers.removeAt(index);
      companionFocusNodes.removeAt(index);
    }

    updateUsedNames();
    update();
  }

  void updateSuggestions(String query, int index) {
    updateUsedNames();

    if (query.length >= 2) {
      filteredSuggestions
        ..clear()
        ..addAll(
          listaTags
              .where((tag) =>
                  tag.toLowerCase().contains(query.toLowerCase()) &&
                  !usedNames.contains(tag))
              .toList(),
        );

      showSuggestions = filteredSuggestions.isNotEmpty;
    } else {
      showSuggestions = false;
      filteredSuggestions.clear();
    }
    debugPrint("Sugestões disponíveis: ${filteredSuggestions.length}");
    update();
  }

  void clearSuggestions(TextEditingController controller) {
    controller.clear();
    showSuggestions = false;
    filteredSuggestions.clear();
    update();
  }

  bool isGuestNameComplete() {
    String guestName = guestController.text.trim();
    return listaTags.contains(guestName);
  }

  void updateUsedNames() {
    usedNames
      ..clear()
      ..addAll(
        [
          guestController.text.trim(),
          ...companionControllers
              .map((controller) => controller.text.trim())
              .where((name) => name.isNotEmpty)
        ],
      );
  }
}
