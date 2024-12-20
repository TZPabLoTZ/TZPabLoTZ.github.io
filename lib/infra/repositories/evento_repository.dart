import 'dart:js' as js;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festit_invited/infra/models/convidado.dart';

import '../models/evento.dart';

class EventoRepository {
  final firestore = FirebaseFirestore.instance;

  Future<List<Evento>> getEventosByUserId(String userId) async {
    try {
      if (js.context['global'] == null) {
        js.context['global'] = js.context;
      }
      final snapshot = await firestore
          .collection('environments')
          .doc('prod')
          .collection('usuarios')
          .doc(userId)
          .collection('eventos')
          .get();

      return snapshot.docs
          .map((doc) => Evento.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar eventos: $e');
      return [];
    }
  }

  Future<List<Convidado>> getConvidadosByUserId(String userId) async {
    try {
      final snapshot = await firestore
          .collection('environments')
          .doc('prod')
          .collection('usuarios')
          .doc(userId)
          .collection('convidados')
          .get();

      return snapshot.docs
          .map((doc) => Convidado.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar eventos: $e');
      return [];
    }
  }

  Future<void> updateGuestStatus(
    String userId,
    Convidado convidado,
    String status,
  ) async {
    try {
      final docRef = firestore
          .collection('environments')
          .doc('prod')
          .collection('usuarios')
          .doc(userId)
          .collection('convidados')
          .doc(convidado.id);

      await docRef.update({
        'status': status,
        if (convidado.acompanhante != null)
          'acompanhanteDeQuem': convidado.acompanhante,
      });

      print('Status do convidado atualizado com sucesso!');
    } catch (e) {
      print('Erro ao atualizar status do convidado: $e');
    }
  }

  Future<void> addGuest(
    String userId,
    Convidado convidado,
  ) async {
    try {
      final docRef = firestore
          .collection('environments')
          .doc('prod')
          .collection('usuarios')
          .doc(userId)
          .collection('convidados')
          .doc();

      await docRef.set(convidado.toMap());

      print('Convidado ou acompanhante adicionado com sucesso!');
    } catch (e) {
      print('Erro ao adicionar convidado: $e');
    }
  }
}
