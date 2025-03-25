import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // empilhar um na frente do outro
        children: [
          Image.asset(
            "assets/images/banner.png",
            width: 400,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/images/stars.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32), // margens para nao encostar nos cantos da tela
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // centralizar itens da tela
              children: <Widget>[
                const SizedBox(height: 185,),
                Image.asset(
                  "assets/images/logo.png",
                  width: 300,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // botao ocupa a tela conforme o padding
                  children: [
                    const SizedBox(height: 32,),
                    const Text(
                      "Sistema de gestao de eventos e pagamentos",
                      textAlign: TextAlign.center, // alinhamento do texto
                      style: TextStyle(
                        fontSize: 20, // tamanho da fonte 
                      ),
                    ),
                    const SizedBox(height: 25,),
                    TextFormField( // campo de texto
                      decoration: const InputDecoration(
                        label: Text("E-mail"), // texto que aparece dentro do campo por default
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text("Senha"),
                      ),
                    ),
                    const SizedBox(height: 32,), // especamento entre campo senha e botao
                    ElevatedButton( // botao
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, "escolha");
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColor.orange,
                        ) // cor de fundo do botao
                      ),
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.black), // cor do texto do botao
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}