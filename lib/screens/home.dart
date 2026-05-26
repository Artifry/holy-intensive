import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leitura.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String livro = "genesis";
  int capitulo = 1;
  bool temProgresso = false;

  @override
  void initState() {
    super.initState();
    carregarProgresso();
  }

  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();

    livro = prefs.getString('livro') ?? "genesis";
    capitulo = prefs.getInt('capitulo') ?? 1;

    // verifica se já existe progresso
    temProgresso = prefs.containsKey('livro');

    setState(() {});
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
              "Sua jornada",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            if (temProgresso) ...[
              const Text(
                "Continuar leitura",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

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

              const SizedBox(height: 30),
            ],

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('livro', "genesis");
                await prefs.setInt('capitulo', 1);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LeituraPage()),
                );
              },
              child: const Text("Iniciar Jornada"),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("🚧 Em construção")),
                );
              },
              child: const Text("Jornada Customizada"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("⚙️ Configuração depois")),
                );
              },
              child: const Text("Configurações"),
            ),
          ],
        ),
      ),
    );
  }
}
