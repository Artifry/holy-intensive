import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeituraPage extends StatefulWidget {
  const LeituraPage({super.key});

  @override
  State<LeituraPage> createState() => _LeituraPageState();
}

class _LeituraPageState extends State<LeituraPage> {
  String texto = "Carregando...";
  String livro = "john";
  int capitulo = 3;

  @override
  void initState() {
    super.initState();
    buscarVersiculo();
  }

  Future<void> buscarVersiculo() async {
    final response = await http.get(
      Uri.parse("https://bible-api.com/$livro+$capitulo"),
    );

    if (response.statusCode == 200) {
      setState(() {
        texto = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$livro $capitulo"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  texto,
                  style: const TextStyle(fontSize: 18, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (capitulo > 1) capitulo--;
                    });
                    buscarVersiculo();
                  },
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      capitulo++;
                    });
                    buscarVersiculo();
                  },
                  child: const Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
