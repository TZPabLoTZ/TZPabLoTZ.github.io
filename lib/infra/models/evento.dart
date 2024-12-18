// ignore_for_file: non_constant_identifier_names

import 'convidado.dart';
import 'tarefa.dart';

class Evento {
  final String? id;
  String? nome;
  String? cover_url;
  String? tipo;
  String? endereco;
  double? orcamento;
  DateTime? data;
  DateTime? data_criacao;
  DateTime? data_atualizacao;
  List<Convidado>? convidados;
  List<Tarefa>? tarefas;

  Evento({
    this.id,
    this.nome,
    this.cover_url,
    this.tipo,
    this.orcamento,
    this.data,
    this.endereco,
    this.data_criacao,
    this.data_atualizacao,
    this.convidados,
    this.tarefas,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (nome != null) {
      result.addAll({'nome': nome});
    }
    if (cover_url != null) {
      result.addAll({'cover_url': cover_url});
    }
    if (tipo != null) {
      result.addAll({'tipo': tipo});
    }
    if (endereco != null) {
      result.addAll({'endereco': endereco});
    }
    if (orcamento != null) {
      result.addAll({'orcamento': orcamento});
    }
    if (data != null) {
      result.addAll({'data': data!.millisecondsSinceEpoch});
    }
    if (data_criacao != null) {
      result.addAll({'data_criacao': data_criacao!.millisecondsSinceEpoch});
    }
    if (data_atualizacao != null) {
      result.addAll(
          {'data_atualizacao': data_atualizacao!.millisecondsSinceEpoch});
    }
    if (convidados != null) {
      result.addAll({'convidados': convidados!.map((x) => x.toMap()).toList()});
    }
    if (tarefas != null) {
      result.addAll({'tarefas': tarefas!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory Evento.fromMap(Map<String, dynamic> map, String id) {
    return Evento(
      id: id,
      nome: map['nome'],
      cover_url: map['cover_url'],
      tipo: map['tipo'],
      endereco: map['endereco'],
      orcamento: map['orcamento']?.toDouble(),
      data: map['data'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data'])
          : null,
      data_criacao: map['data_criacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data_criacao'])
          : null,
      data_atualizacao: map['data_atualizacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data_atualizacao'])
          : null,
      convidados: map['convidados'] != null
          ? List<Convidado>.from(
              map['convidados']?.map((x) => Convidado.fromMap(x)))
          : null,
      tarefas: map['tarefas'] != null
          ? List<Tarefa>.from(map['tarefas']?.map((x) => Tarefa.fromMap(x)))
          : null,
    );
  }
}
