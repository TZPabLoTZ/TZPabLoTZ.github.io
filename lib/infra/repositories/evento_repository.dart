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

  Future<List<Convidado>> updateGuest(String userId) async {
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
}
