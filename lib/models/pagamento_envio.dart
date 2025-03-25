import 'dart:convert';

class PagamentoEnvio{

  String descricao;
  String data;
  String tipoEvento;
  String recorrencia;
  int? intervaloRepeticao;
  int? quantidadeEventos;
  String usuario;
  double valor;

  PagamentoEnvio({
    required this.descricao,
    required this.data,
    required this.tipoEvento,
    required this.recorrencia,
    required this.intervaloRepeticao,
    required this.quantidadeEventos,
    required this.usuario,
    required this.valor,
  });

  // Construtor Factory para criar um objeto a partir de um Map
  factory PagamentoEnvio.fromMap(Map<String, dynamic> map) {
    return PagamentoEnvio(
      descricao: map['descricao'] as String,
      data: map['data'] as String,
      tipoEvento: map['tipoEvento'] as String,
      recorrencia: map['recorrencia'] as String,
      intervaloRepeticao: map['intervaloRepeticao'] as int,
      quantidadeEventos: map['quantidadeEventos'] as int,
      usuario: map['usuario'] as String,
      valor: map['valor'] as double,
    );
  }

  // Converte o objeto para um Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descricao': descricao,
      'data': data,
      'tipoEvento': tipoEvento,
      'recorrencia': recorrencia,
      'intervaloRepeticao': intervaloRepeticao,
      'quantidadeEventos': quantidadeEventos,
      'usuario': usuario,
      'valor': valor,
    };
  }

  // Método para criar uma cópia do objeto com valores atualizados
  PagamentoEnvio copyWith({
    String? descricao,
    String? data,
    String? tipoEvento,
    String? recorrencia,
    int? intervaloRepeticao,
    int? quantidadeEventos,
    String? usuario,
    double? valor,
  }) {
    return PagamentoEnvio(
      descricao: descricao ?? this.descricao,
      data: data ?? this.data,
      tipoEvento: tipoEvento ?? this.tipoEvento,
      recorrencia: recorrencia ?? this.recorrencia,
      intervaloRepeticao: intervaloRepeticao ?? this.intervaloRepeticao,
      quantidadeEventos: quantidadeEventos ?? this.quantidadeEventos,
      usuario: usuario ?? this.usuario,
      valor: valor ?? this.valor,
    );
  }

  // Converte o objeto para JSON
  String toJson() => json.encode(toMap());

  // Construtor Factory para criar um objeto a partir de um JSON
  factory PagamentoEnvio.fromJson(String source) =>
      PagamentoEnvio.fromMap(json.decode(source) as Map<String, dynamic>);

}