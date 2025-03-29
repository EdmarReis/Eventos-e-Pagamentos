import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/services/api_key.dart';
import 'package:flutter_banco_douro/services/user_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<void> fazerLogin(String email, String senha, BuildContext context) async {
    //final String url = "http://10.0.2.2:8085/login";
    //final String url = "http://192.168.0.178:8085/login"; // meu mac
    final String url = "http://192.168.0.190:8085/login"; //pc windows

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': apiKey,
        },
        body: jsonEncode({
          "login": email,
          "senha": senha,
        }),
      );

      if (response.statusCode == 200) {
        UserManager().setUser(email);
        Navigator.pushReplacementNamed(context, "escolha");
      } else if (response.statusCode == 404) {
        _mostrarMensagem(context, "Usuário e/ou senha inválidos.");
      } else {
        _mostrarMensagem(context, "Erro ao fazer login: ${response.statusCode}");
      }
    } catch (e) {
      _mostrarMensagem(context, "Erro de conexão! Entre em contato com o administrador do sistema.");
    }
  }

  void _mostrarMensagem(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: Text(mensagem),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
