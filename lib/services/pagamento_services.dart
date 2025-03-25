import 'package:flutter_banco_douro/models/pagamento.dart';
import 'package:flutter_banco_douro/models/pagamento_envio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PagamentoServices {

  //final String baseUrl = "http://10.0.2.2:8085"; //localhost
  //final String baseUrl = "http://192.168.0.178:8085"; // meu mac
  final String baseUrl = "http://192.168.0.190:8085"; //pc windows

  Future<void> addPagamento(PagamentoEnvio compromissoEnvio) async {
    
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/criarEventoPagamento"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(compromissoEnvio.toMap()), // Convertendo para JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Pagamento criado com sucesso!");
      } else {
        print("Erro ao criar pagamento: ${response.statusCode}");
        print("Resposta: ${response.body}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  Future<List<Pagamento>> fetchPagamentos() async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/envio/pagamentos/app"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Pagamento.fromJson(json)).toList();
      } else {
        throw Exception("Erro ao carregar pagamentos: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Falha na conexão: $e");
    }
  }

  Future<bool> finalizarPagamento(int idEvento) async {
    final url = Uri.parse("http://192.168.0.190:8085/finalizar/$idEvento");

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        return true; // Finalização bem-sucedida
      } else {
        return false; // Falha na finalização
      }
    } catch (e) {
      return false; // Erro de conexão
    }
  }

}