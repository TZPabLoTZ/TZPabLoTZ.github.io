import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/evento.dart';

class EventoRepository {
  final firestore = FirebaseFirestore.instance;

  Future<List<Evento>> getEventosByUserId(String userId) async {
    try {
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
}
