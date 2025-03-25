class Pagamento{

  final String acompanhamento;
  final String descricao;
  final String data;
  final double valor;
  final String ocorrencia;
  final int idEvento;

  Pagamento({
    required this.acompanhamento,
    required this.descricao,
    required this.data,
    required this.valor,
    required this.ocorrencia,
    required this.idEvento,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) {
    return Pagamento(
      acompanhamento: json['acompanhamento'] ?? '',
      descricao: json['descricao'] ?? '',
      data: json['data'] ?? '',
      valor: json['valor'] ?? '',
      ocorrencia: json['ocorrencia'] ?? '',
      idEvento: json['idEvento'] ?? 0,      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acompanhamento': acompanhamento,
      'descricao': descricao,
      'data': data,
      'valor': valor,
      'ocorrencia': ocorrencia,
      'idEvento': idEvento,
    };
  }

}