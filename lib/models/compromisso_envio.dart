import 'dart:convert';

class CompromissoEnvio {
  String descricao;
  String data;
  String tipoEvento;
  String recorrencia;
  int? intervaloRepeticao;
  int? quantidadeEventos;
  String usuario;
  String horario;

  CompromissoEnvio({
    required this.descricao,
    required this.data,
    required this.tipoEvento,
    required this.recorrencia,
    required this.intervaloRepeticao,
    required this.quantidadeEventos,
    required this.usuario,
    required this.horario,
  });

  // Construtor Factory para criar um objeto a partir de um Map
  factory CompromissoEnvio.fromMap(Map<String, dynamic> map) {
    return CompromissoEnvio(
      descricao: map['descricao'] as String,
      data: map['data'] as String,
      tipoEvento: map['tipoEvento'] as String,
      recorrencia: map['recorrencia'] as String,
      intervaloRepeticao: map['intervaloRepeticao'] as int,
      quantidadeEventos: map['quantidadeEventos'] as int,
      usuario: map['usuario'] as String,
      horario: map['horario'] as String,
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
      'horario': horario,
    };
  }

  // Método para criar uma cópia do objeto com valores atualizados
  CompromissoEnvio copyWith({
    String? descricao,
    String? data,
    String? tipoEvento,
    String? recorrencia,
    int? intervaloRepeticao,
    int? quantidadeEventos,
    String? usuario,
    String? horario,
  }) {
    return CompromissoEnvio(
      descricao: descricao ?? this.descricao,
      data: data ?? this.data,
      tipoEvento: tipoEvento ?? this.tipoEvento,
      recorrencia: recorrencia ?? this.recorrencia,
      intervaloRepeticao: intervaloRepeticao ?? this.intervaloRepeticao,
      quantidadeEventos: quantidadeEventos ?? this.quantidadeEventos,
      usuario: usuario ?? this.usuario,
      horario: horario ?? this.horario,
    );
  }

  // Converte o objeto para JSON
  String toJson() => json.encode(toMap());

  // Construtor Factory para criar um objeto a partir de um JSON
  factory CompromissoEnvio.fromJson(String source) =>
      CompromissoEnvio.fromMap(json.decode(source) as Map<String, dynamic>);
}
