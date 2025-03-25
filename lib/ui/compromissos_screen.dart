import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/compromisso.dart';
import 'package:flutter_banco_douro/services/compromisso_service.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:flutter_banco_douro/ui/widgets/add_compromisso_model.dart';

class CompromissosScreen extends StatefulWidget {
  const CompromissosScreen({super.key});

  @override
  CompromissosScreenState createState() => CompromissosScreenState();
}

class CompromissosScreenState extends State<CompromissosScreen> {
  List<Compromisso> compromissos = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCompromissos();
  }

  Future<void> fetchCompromissos() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      compromissos = await CompromissoService().fetchCompromissos();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          "Meus Compromissos",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
              : RefreshIndicator(
                onRefresh: fetchCompromissos,
                child:
                    compromissos.isEmpty
                        ? const Center(
                          child: Text(
                            "Nenhum registro recente",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: compromissos.length,
                          itemBuilder: (context, index) {
                            var compromisso = compromissos[index];

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                title: Text(
                                  compromisso.acompanhamento,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "📝 Descrição: ${compromisso.descricao}\n"
                                    "📅 Data: ${compromisso.data}\n"
                                    "⏰ Horário: ${compromisso.horario}\n"
                                    "🔄 Ocorrência: ${compromisso.ocorrencia}\n"
                                    "🆔 ID Evento: ${compromisso.idEvento}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      height: 1.5,
                                    ),
                                  ),
                                ),

                                trailing: PopupMenuButton<String>(
  onSelected: (value) async {
    if (value == "excluir") {
      bool? confirmacao = await _confirmarExclusao(context);
      
      if (confirmacao == true) {
        _finalizarCompromisso(context, compromisso.idEvento);
      }
    }
  },
  itemBuilder: (BuildContext context) => [
    const PopupMenuItem(
      value: "excluir",
      child: ListTile(
        leading: Icon(Icons.delete, color: Colors.red),
        title: Text("Excluir"),
      ),
    ),
  ],
  child: const Icon(
    Icons.settings,
    color: Colors.grey,
  ),
),



                              ),
                            );
                          },
                        ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: const AddCompromissoModel(),
              );
            },
          );
          fetchCompromissos();
        },
        backgroundColor: AppColor.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _finalizarCompromisso(BuildContext context, int idEvento) async {
    bool sucesso = await CompromissoService().finalizarCompromisso(idEvento);

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Compromisso finalizado com sucesso!")),
      );
      fetchCompromissos(); // Atualiza a lista
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao finalizar compromisso.")),
      );
    }
  }

  Future<bool?> _confirmarExclusao(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text(
            "Tem certeza de que deseja excluir este pagamento?",
          ),
          actions: [
            TextButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pop(false), // Usuário clicou em "Não"
              child: const Text("Não"),
            ),
            TextButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pop(true), // Usuário clicou em "Sim"
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  
}
