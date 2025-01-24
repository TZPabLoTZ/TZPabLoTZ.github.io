import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/convidado.dart';
import '../../infra/models/evento.dart';
import '../../infra/repositories/evento_repository.dart';
import '../guest_confirmation/guest_confirmation_page.dart';

class ReceiveGuestController extends GetxController {
  final repository = EventoRepository();

  final scrollController = ScrollController();

  TextEditingController guestController = TextEditingController();
  FocusNode guestFocusNode = FocusNode();

  List<TextEditingController> guestControllers = [];
  List<FocusNode> guestFocusNodes = [];

  List<String> filteredSuggestions = [];
  List<String> usedNames = [];

  List<Convidado> guestNames = [];

  bool showSuggestions = false;

  String? userId;
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

  String? idLink;

  void setUserId(String id) {
    idLink = id;
    update();
  }

  void getUserId() {
    window.location.href;
    debugPrint(window.location.href.split('/').last);
    userId = window.location.href.split('/').last;

    if (userId != null) {
      getEvento(userId!);
      getConvidado(userId!);
      final receiveGuestController = Get.find<ReceiveGuestController>();
      receiveGuestController.setUserId(userId!);
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
      debugPrint('Erro ao buscar evento: $e');
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
      debugPrint('Erro ao buscar convidados: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void addCompanionField() {
    int? guestLimit = evento?.qtd_acompanhante;

    if (guestLimit == null || guestControllers.length < guestLimit) {
      guestControllers.add(TextEditingController());
      guestFocusNodes.add(FocusNode());
      update();
    } else {
      debugPrint("Limite de acompanhantes atingido.");
    }
  }

  void removeCompanionField(int index) {
    if (index >= 0 && index < guestControllers.length) {
      guestControllers.removeAt(index);
      guestFocusNodes.removeAt(index);
    }

    updateUsedNames();
    update();
  }

  void updateSuggestions(String query) {
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
    return guestController.text.trim().length >= 3;
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

  Future<bool> updateGuestStatus(
    String userId,
    String nome,
    String status, {
    List<String>? acompanhantesNomes,
  }) async {
    try {
      debugPrint('Buscando convidado com nome: "$nome"');
      Convidado? convidado;

      for (var guest in guestNames) {
        if (guest.nome.trim().toLowerCase() == nome.trim().toLowerCase()) {
          convidado = guest;
          break;
        }
      }

      if (convidado == null) {
        debugPrint('Convidado não encontrado: $nome. Criando novo convidado.');

        convidado = Convidado(
          id: null,
          nome: nome,
          grupo: 'Sem grupo, Adicionado via convite',
          status: status,
          acompanhante: null,
        );

        await repository.addGuest(userId, convidado);

        return true;
      }

      if (convidado.id == null || convidado.grupo.isEmpty) {
        debugPrint(
            'Convidado encontrado, mas id ou grupo está vazio: ${convidado.toMap()}');
        return false;
      }

      await repository.updateGuestStatus(
        userId,
        convidado.copyWith(status: status),
        status,
      );

      if (acompanhantesNomes != null && acompanhantesNomes.isNotEmpty) {
        for (var acompanhanteNome in acompanhantesNomes) {
          final acompanhante = Convidado(
            id: null,
            nome: acompanhanteNome,
            grupo: convidado.grupo,
            status: 'Confirmado',
            acompanhante: nome,
          );

          await repository.addGuest(userId, acompanhante);
        }
      }

      debugPrint('Status do convidado e acompanhantes atualizado com sucesso!');
      return true;
    } catch (e) {
      debugPrint('Erro ao atualizar status do convidado: $e');
      return false;
    }
  }

  Future<bool> updateGuestStatusPending(
    String userId,
    String nome,
    String status,
  ) async {
    try {
      for (var guest in guestNames) {
        if (guest.nome == nome) {
          convidado = guest;
          break;
        }
      }

      if (convidado != null) {
        await repository.updateGuestStatus(
          userId,
          convidado!,
          status,
        );
        debugPrint('Status do convidado atualizado com sucesso!');
        return true;
      } else {
        debugPrint('Convidado não encontrado.');
        return false;
      }
    } catch (e) {
      debugPrint('Erro ao atualizar status do convidado: $e');
      return true;
    }
  }

  Future<void> confirmPresence() async {
    String convidado = guestController.text.trim();
    List<String> acompanhantesNomes = guestControllers
        .map((controller) => controller.text.trim())
        .where((nome) => nome.isNotEmpty)
        .toList();

    bool result = await updateGuestStatus(
      userId!,
      convidado,
      'Confirmado',
      acompanhantesNomes: acompanhantesNomes,
    );

    if (result) {
      Get.offAndToNamed(GuestConfirmationPage.route);
    } else {
      Get.snackbar(
        'Erro',
        'Erro ao atualizar o status do convidado.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    }
  }

  Future<void> declinePresence() async {
    String convidado = guestController.text.trim();

    bool result = await updateGuestStatusPending(
      userId!,
      convidado,
      'Ausente',
    );

    if (result) {
      Get.offAndToNamed(GuestConfirmationPage.route);
    } else {
      Get.snackbar(
        'Erro',
        'Erro ao atualizar o status do convidado.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    }
  }
}
