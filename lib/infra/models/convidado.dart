import 'dart:convert';

class Convidado {
  String? id;
  String nome;
  String grupo;
  String status;

  Convidado({
    this.id,
    required this.nome,
    required this.grupo,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'nome': nome});
    result.addAll({'grupo': grupo});
    result.addAll({'status': status});

    return result;
  }

  factory Convidado.fromMap(Map<String, dynamic> map) {
    return Convidado(
      id: map['id'],
      nome: map['nome'] ?? '',
      grupo: map['grupo'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Convidado.fromJson(String source) =>
      Convidado.fromMap(json.decode(source));

  static const String pendente = "PENDENTE";
  static const String confirmado = "CONFIRMADO";
  static const String ausente = "AUSENTE";
}
