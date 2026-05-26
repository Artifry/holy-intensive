import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  String idioma = "pt";

  @override
  void initState() {
    super.initState();
    carregarIdioma();
  }

  Future<void> carregarIdioma() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      idioma = prefs.getString('idioma') ?? "pt";
    });
  }

  Future<void> salvarIdioma(String novoIdioma) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', novoIdioma);

    setState(() {
      idioma = novoIdioma;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("✅ Idioma atualizado")));
  }

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
              value: idioma,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "pt", child: Text("🇧🇷 Português")),
                DropdownMenuItem(value: "en", child: Text("🇺🇸 Inglês")),
              ],
              onChanged: (value) {
                salvarIdioma(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
