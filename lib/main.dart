//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_banco_douro/api/firebase_api.dart';
import 'package:flutter_banco_douro/ui/compromissos_screen.dart';
import 'package:flutter_banco_douro/ui/escolha_screen.dart';
import 'package:flutter_banco_douro/ui/login_screen.dart';
import 'package:flutter_banco_douro/ui/pagamentos_screen.dart';
//import 'firebase_options.dart'; // Se você gerou este arquivo

//void main() {
  //runApp(const BancoDouroApp());
//}
void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await FirebaseApi().initiNotifications();
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


