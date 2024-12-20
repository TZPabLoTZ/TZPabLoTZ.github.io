class Convidado {
  String? id;
  String nome;
  String grupo;
  String status;
  String? acompanhante;

  Convidado({
    this.id,
    required this.nome,
    required this.grupo,
    required this.status,
    this.acompanhante,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'nome': nome});
    result.addAll({'grupo': grupo});
    result.addAll({'status': status});
    if (acompanhante != null) {
      result.addAll({'acompanhante': acompanhante});
    }

    return result;
  }

  factory Convidado.fromMap(Map<String, dynamic> map, String id) {
    return Convidado(
      id: id,
      nome: map['nome'] ?? '',
      grupo: map['grupo'] ?? '',
      status: map['status'] ?? '',
      acompanhante: map['acompanhante'],
    );
  }

  static const String pendente = "PENDENTE";
  static const String confirmado = "CONFIRMADO";
  static const String ausente = "AUSENTE";
}
