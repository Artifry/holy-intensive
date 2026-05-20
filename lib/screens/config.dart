import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  final String versao;
  final Function(String) onChange;

  const ConfigPage({super.key, required this.versao, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Idioma da Bíblia",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(
              value: versao,
              items: const [
                DropdownMenuItem(value: "kjv", child: Text("🇺🇸 Inglês")),
                DropdownMenuItem(
                  value: "almeida",
                  child: Text("🇧🇷 Português"),
                ),
                DropdownMenuItem(value: "rv1960", child: Text("🇪🇸 Espanhol")),
              ],
              onChanged: (value) {
                onChange(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
