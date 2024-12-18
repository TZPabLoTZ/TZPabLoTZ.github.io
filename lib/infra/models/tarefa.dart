import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Tarefa {
  String? id;
  String? titulo;
  String? status;
  String? prazo;
  DateTime? data_criacao;
  DateTime? data_atualizacao;

  Tarefa({
    this.id,
    this.titulo,
    this.status,
    this.prazo,
    this.data_criacao,
    this.data_atualizacao,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (titulo != null) {
      result.addAll({'titulo': titulo});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (prazo != null) {
      result.addAll({'prazo': prazo});
    }
    if (data_criacao != null) {
      result.addAll({'data_criacao': data_criacao!.millisecondsSinceEpoch});
    }
    if (data_atualizacao != null) {
      result.addAll(
          {'data_atualizacao': data_atualizacao!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      status: map['status'],
      prazo: map['prazo'],
      data_criacao: map['data_criacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data_criacao'])
          : null,
      data_atualizacao: map['data_atualizacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data_atualizacao'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tarefa.fromJson(String source) => Tarefa.fromMap(json.decode(source));

  static const String pendente = "PENDENTE";
  static const String concluida = "CONCLUIDA";
}
