import 'dart:html';

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
      Get.find().setUserId(userId);
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

  Future<bool> updateGuestStatus(
    String userId,
    String nome,
    String status, {
    String? acompanhanteNome,
  }) async {
    try {
      print('Buscando convidado com nome: "$nome"');
      final convidado = guestNames.firstWhere(
        (guest) => guest.nome.trim().toLowerCase() == nome.trim().toLowerCase(),
        orElse: () {
          print('Convidado não encontrado na lista: $nome');
          return Convidado(
            id: '',
            nome: '',
            grupo: '',
            status: '',
          );
        },
      );

      if (convidado.id!.isEmpty || convidado.grupo.isEmpty) {
        debugPrint(
            'Convidado encontrado, mas id ou grupo está vazio: ${convidado.toMap()}');
        return false;
      }

      await repository.updateGuestStatus(
        userId,
        convidado.copyWith(status: status),
        status,
      );

      if (acompanhanteNome != null && acompanhanteNome.isNotEmpty) {
        final acompanhante = Convidado(
          id: null,
          nome: acompanhanteNome,
          grupo: convidado.grupo,
          status: 'Confirmado',
          acompanhante: nome,
        );

        await repository.addGuest(userId, acompanhante);
      }

      print('Status do convidado atualizado com sucesso!');
      return true;
    } catch (e) {
      print('Erro ao atualizar status do convidado: $e');
      return false;
    }
  }

  Future<void> updateGuestStatuspending(
    String userId,
    String nome,
    String status,
  ) async {
    try {
      final convidado = guestNames.firstWhere(
        (guest) => guest.nome == nome,
      );

      await repository.updateGuestStatus(
        userId,
        convidado,
        status,
      );

      print('Status do convidado atualizado com sucesso!');
    } catch (e) {
      print('Erro ao atualizar status do convidado: $e');
    }
  }

  void scrollToFocusedField(BuildContext context, ScrollController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FocusScope.of(context).focusedChild != null) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
