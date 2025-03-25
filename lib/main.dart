import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/ui/compromissos_screen.dart';
import 'package:flutter_banco_douro/ui/escolha_screen.dart';
import 'package:flutter_banco_douro/ui/login_screen.dart';
import 'package:flutter_banco_douro/ui/pagamentos_screen.dart';

void main() {
  runApp(const BancoDouroApp());
}

class BancoDouroApp extends StatelessWidget {
  const BancoDouroApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (context) => const LoginScreen(),
        "escolha": (context) => EscolhaScreen(),
        "telaCompromissos": (context) => CompromissosScreen(),
        "telaPagamentos": (context) => PagamentosScreen(), 
      },
      initialRoute: "login",
    );
  }
}


