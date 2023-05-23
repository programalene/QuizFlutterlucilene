import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'administracao.dart';

class Adicionar extends StatefulWidget {
  @override
  _AdicionarState createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {
  final formKey = GlobalKey<FormState>();
  final perguntaController = TextEditingController();
  final resposta1Controller = TextEditingController();
  final resposta2Controller = TextEditingController();
  final resposta3Controller = TextEditingController();
  final resposta4Controller = TextEditingController();
  final alternativaCorretaController = TextEditingController();
  Future<void> _submitForm() async {
    final url = Uri.parse('https://apiperguntassenac3.azurewebsites.net//perguntas');
    final response = await http.post(
      url,
      body: {
        'pergunta': perguntaController.text,
        'resposta1': resposta1Controller.text,
        'resposta2': resposta2Controller.text,
        'resposta3': resposta3Controller.text,
        'resposta4': resposta4Controller.text,
        'alternativacorreta': alternativaCorretaController.text,
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // Pergunta criada com sucesso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Administracao()),
      );
    } else {
      // Falha ao criar pergunta
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao criar a pergunta.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff03DAC5),
      appBar: AppBar(
        title: Text('Adicionar pergunta'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: perguntaController,
                  decoration: InputDecoration(labelText: 'Pergunta'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                    controller:resposta1Controller,
                  decoration: InputDecoration(labelText: 'Resposta 1'),
                ),
                TextFormField(
                    controller:resposta2Controller,
                  decoration: InputDecoration(labelText: 'Resposta 2'),
                ),
                TextFormField(
                    controller:resposta3Controller,
                  decoration: InputDecoration(labelText: 'Resposta 3'),
                ),
                TextFormField(
                  controller:resposta4Controller,
                  decoration: InputDecoration(labelText: 'Resposta 4'),
                ),
                TextFormField(
                    controller:alternativaCorretaController,
                  decoration: InputDecoration(labelText: 'Alternativa correta'),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                  ),
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}