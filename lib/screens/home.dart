import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leitura.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String livro = "john";
  int capitulo = 3;

  @override
  void initState() {
    super.initState();
    carregarProgresso();
  }

  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      livro = prefs.getString('livro') ?? "john";
      capitulo = prefs.getInt('capitulo') ?? 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Holy Intensive")),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Continuar leitura",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: Text("$livro $capitulo"),
                subtitle: const Text("Toque para continuar"),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LeituraPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
