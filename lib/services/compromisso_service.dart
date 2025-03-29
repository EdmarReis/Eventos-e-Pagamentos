import 'dart:convert';
import 'package:flutter_banco_douro/models/compromisso.dart';
import 'package:flutter_banco_douro/models/compromisso_envio.dart';
import 'package:flutter_banco_douro/services/api_key.dart';
import 'package:flutter_banco_douro/services/user_manager.dart';
import 'package:http/http.dart' as http;

class CompromissoService {
  //final String baseUrl = "http://10.0.2.2:8085"; //localhost
  //final String baseUrl = "http://192.168.0.178:8085"; // meu mac
  final String baseUrl = "http://192.168.0.190:8085"; //pc windows

  Future<void> addCompromisso(CompromissoEnvio compromissoEnvio) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/criarEventoCompromisso"),
        headers: {'Content-Type': 'application/json','X-API-KEY':apiKey},
        body: jsonEncode(compromissoEnvio.toMap()), // Convertendo para JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Compromisso criado com sucesso!");
      } else {
        print("Erro ao criar compromisso: ${response.statusCode}");
        print("Resposta: ${response.body}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  Future<List<Compromisso>> fetchCompromissos() async {
    try {
      String user = UserManager().getUser() as String;
      final response = await http.post(
        headers: {'Content-Type': 'application/json','X-API-KEY':apiKey},
        Uri.parse("$baseUrl/envio/compromissos/app/$user"),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Compromisso.fromJson(json)).toList();
      } else {
        throw Exception(
          "Erro ao carregar compromissos: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Falha na conexão: $e");
    }
  }

  Future<bool> finalizarCompromisso(int idEvento) async {
    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json','X-API-KEY':apiKey},
        Uri.parse("$baseUrl/finalizar/$idEvento"),
      );
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
