import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/convidado.dart';
import '../../infra/models/evento.dart';
import '../../infra/repositories/evento_repository.dart';

class ReceiveGuestController extends GetxController {
  final repository = EventoRepository();

  final guestController = TextEditingController();
  final guestFocusNode = FocusNode();

  List<TextEditingController> guestControllers = [];
  List<FocusNode> guestFocusNodes = [];

  List<String> filteredSuggestions = [];
  List<String> usedNames = [];

  List<Convidado> guestNames = [];

  bool showSuggestions = false;

  String? id;
  Evento? evento;
  Convidado? convidado;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserId();
    });
  }

  void getUserId() {
    final uri = Uri.base;
    final segments = uri.pathSegments;
    id = segments.length > 1 ? segments[1] : null;

    if (id != null) {
      getEvento(id!);
      getConvidado(id!);
    } else {
      isLoading = false;
      update();
    }
  }

  Future<void> getEvento(String userId) async {
    try {
      isLoading = true;
      update();
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

  Future<void> getConvidado(String id) async {
    try {
      isLoading = true;
      update();

      final fetchConvidados = await repository.getConvidadosByUserId(id);
      if (fetchConvidados.isNotEmpty) {
        guestNames = fetchConvidados;
        convidado = fetchConvidados.first;
      } else {
        guestNames = [];
        convidado = null;
      }
    } catch (e) {
      print('Erro ao buscar convidados: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void addCompanionField() {
    guestControllers.add(TextEditingController());
    guestFocusNodes.add(FocusNode());
    update();
  }

  void removeCompanionField(int index) {
    if (index >= 0 && index < guestControllers.length) {
      guestControllers.removeAt(index);
      guestFocusNodes.removeAt(index);
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
          guestNames
              .where((guest) => guest.status == "Pendente")
              .map((guest) => guest.nome)
              .where((name) =>
                  name.toLowerCase().contains(query.toLowerCase()) &&
                  !usedNames.contains(name))
              .toList(),
        );

      showSuggestions = filteredSuggestions.isNotEmpty;
    } else {
      showSuggestions = false;
      filteredSuggestions.clear();
    }

    update();
  }

  void clearSuggestions(TextEditingController controller) {
    controller.clear();
    showSuggestions = false;
    filteredSuggestions.clear();
    update();
  }

  bool isGuestNameComplete() {
    String guestName = guestController.text.toLowerCase().tr;
    return guestNames.any((guest) => guest.nome.toLowerCase().tr == guestName);
  }

  void updateUsedNames() {
    usedNames
      ..clear()
      ..addAll(
        [
          guestController.text.trim(),
          ...guestControllers
              .map((controller) => controller.text.trim())
              .where((name) => name.isNotEmpty)
        ],
      );
  }
}
