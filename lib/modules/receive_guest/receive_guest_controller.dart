import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiveGuestController extends GetxController {
  final List<String> filteredSuggestions = [];
  final List<String> usedNames = [];

  bool showSuggestions = false;

  final List<String> listaTags = [
    'Carlos',
    'Ana',
    'Annabelle',
    'Maria',
    'João',
    'Pedro',
    'Julia',
  ];

  final guestController = TextEditingController();
  final guestFocusNode = FocusNode();

  final List<TextEditingController> companionControllers = [];
  final List<FocusNode> companionFocusNodes = [];

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
