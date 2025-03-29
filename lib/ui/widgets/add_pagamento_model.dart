import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banco_douro/models/pagamento_envio.dart';
import 'package:flutter_banco_douro/services/pagamento_services.dart';
import 'package:flutter_banco_douro/services/user_manager.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';

class AddPagamentoModel extends StatefulWidget {
  const AddPagamentoModel({super.key});

  @override
  State<AddPagamentoModel> createState() => _AddCompromissoModelState();
}

class _AddCompromissoModelState extends State<AddPagamentoModel> {
  String _compromissoType = "REPETICAO";
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _intervaloRepeticaoController =
      TextEditingController();
  final TextEditingController _quantidadeEventosController =
      TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
        top: 32,
        bottom:
            MediaQuery.of(context)
                .viewInsets
                .bottom, // quando abre o teclado joga o campo para cima para nao ficar por cima do campo
      ),
      child: SingleChildScrollView(
        // era um colum, mas dava problema quando abria o teclado pois cobria os campos de textos
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                "assets/images/icon_add_account.png",
                width: 64,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Adicionar novo pagamento",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
              "Preencha os dados abaixo:",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),

            const SizedBox(height: 16),
            const Text("Tipo do recorrencia"),

            DropdownButton<String>(
              value: _compromissoType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "REPETICAO", child: Text("Repetição")),
                DropdownMenuItem(value: "MENSAL", child: Text("Mensal")),
                DropdownMenuItem(value: "UNICA", child: Text("Unica")),
              ],
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    _compromissoType = valor;

                    // Regras de desabilitação e limpeza de campos
                    if (_compromissoType == "MENSAL") {
                      _intervaloRepeticaoController.text = "";
                    }
                    if (_compromissoType == "UNICA") {
                      _intervaloRepeticaoController.text = "";
                      _quantidadeEventosController.text = "";
                    }
                  });
                }
              },
            ),

            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(label: Text("Descrição")),
            ),
            TextFormField(
              controller: _dataController,
              decoration: const InputDecoration(
                labelText: "Data",
                suffixIcon: Icon(Icons.calendar_today), // Ícone de calendário
              ),
              readOnly: true, // Impede digitação manual
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      "${pickedDate.day.toString().padLeft(2, '0')}/"
                      "${pickedDate.month.toString().padLeft(2, '0')}/"
                      "${pickedDate.year}";
                  _dataController.text =
                      formattedDate; // Define o valor no campo
                }
              },
            ),
            TextFormField(
              controller: _intervaloRepeticaoController,
              decoration: const InputDecoration(
                labelText: "Intervalo de repetição",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              enabled:
                  _compromissoType == "REPETICAO", // Desativa quando necessário
            ),
            TextFormField(
              controller: _quantidadeEventosController,
              decoration: const InputDecoration(
                labelText: "Quantidade de eventos",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              enabled:
                  _compromissoType == "REPETICAO" ||
                  _compromissoType == "MENSAL", // Desativa quando necessário
            ),

            TextFormField(
              controller: _valorController,
              decoration: const InputDecoration(labelText: "Valor"),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*'),
                ), // Permite números com ponto decimal
              ],
            ),

            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        (isLoading)
                            ? null // isLoading true o botam fica desabilitado
                            : () {
                              // false comportamento normal
                              onButtonCancelClicked();
                            },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onButtonAddClicked();
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColor.orange),
                    ),
                    child:
                        (isLoading)
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            // isLoading true barra progresso
                            : const Text(
                              // false aparece o texto
                              "Adicionar",
                              style: TextStyle(color: Colors.black),
                            ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onButtonCancelClicked() {
    if (!isLoading) {
      Navigator.pop(
        context,
      ); // fecha o modal voltando para a tela de baixo dele
    }
  }

  onButtonAddClicked() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String descricao = _descricaoController.text;
      String data = formatarData(_dataController.text);
      String intervaloRepeticaoStr = _intervaloRepeticaoController.text;
      String quantidadeEventosStr = _quantidadeEventosController.text;
      double? valor = double.tryParse(_valorController.text);

      int? intervaloRepeticao =
          intervaloRepeticaoStr.isEmpty
              ? null
              : int.tryParse(intervaloRepeticaoStr);
      int? quantidadeEventos =
          quantidadeEventosStr.isEmpty
              ? null
              : int.tryParse(quantidadeEventosStr);

      print(
        "$_compromissoType\n desc $descricao \n data $data \n inter $intervaloRepeticao \n quantStr $quantidadeEventosStr \n quant $quantidadeEventos \n valor $valor",
      );

      if ((_compromissoType == "REPETICAO" &&
              (descricao.isEmpty ||
                  data.isEmpty ||
                  intervaloRepeticao == null ||
                  quantidadeEventos == null ||
                  quantidadeEventos <= 0 ||
                  valor == null)) ||
          (_compromissoType == "MENSAL" &&
              (descricao.isEmpty ||
                  data.isEmpty ||
                  quantidadeEventos == null ||
                  valor == null)) ||
          (_compromissoType == "UNICA" &&
              (descricao.isEmpty || data.isEmpty || valor == null))) {
        setState(() {
          isLoading = false;
        });

        // Exibir popup informando que os campos são obrigatórios
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Atenção"),
              content: Text(
                "Verifique se todos os campos estão preenchidos e válidos.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return; // Interrompe a execução se os campos estiverem vazios
      }

      PagamentoEnvio pagamentoEnvio = PagamentoEnvio(
        descricao: descricao,
        data: data,
        tipoEvento: "LEMBRETE",
        recorrencia: _compromissoType,
        intervaloRepeticao: intervaloRepeticao,
        quantidadeEventos: quantidadeEventos,
        //usuario: "Edmar",
        usuario: UserManager().getUser() as String,
        valor: valor!,
      );

      await PagamentoServices().addPagamento(pagamentoEnvio);
      closeModal();
    }
  }

  closeModal() {
    Navigator.pop(context);
  }

  String formatarData(String data) {
    try {
      List<String> partes = data.split('/');
      DateTime dateTime = DateTime(
        int.parse(partes[2]), // Ano
        int.parse(partes[1]), // Mês
        int.parse(partes[0]), // Dia
      );
      return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    } catch (e) {
      print("Erro ao formatar a data: $e");
      return "";
    }
  }
}
