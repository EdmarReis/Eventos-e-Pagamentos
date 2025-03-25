class Compromisso {
  final String acompanhamento;
  final String descricao;
  final String data;
  final String horario;
  final String ocorrencia;
  final int idEvento;
 

  Compromisso({
    required this.acompanhamento,
    required this.descricao,
    required this.data,
    required this.horario,
    required this.ocorrencia,
    required this.idEvento,
  });

  factory Compromisso.fromJson(Map<String, dynamic> json) {
    return Compromisso(
      acompanhamento: json['acompanhamento'] ?? '',
      descricao: json['descricao'] ?? '',
      data: json['data'] ?? '',
      horario: json['horario'] ?? '',
      ocorrencia: json['ocorrencia'] ?? '',
      idEvento: json['idEvento'] ?? 0,      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acompanhamento': acompanhamento,
      'descricao': descricao,
      'data': data,
      'horario': horario,
      'ocorrencia': ocorrencia,
      'idEvento': idEvento,
    };
  }
}
