import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';

class LeituraPage extends StatefulWidget {
  const LeituraPage({super.key});

  @override
  State<LeituraPage> createState() => _LeituraPageState();
}

class _LeituraPageState extends State<LeituraPage> {
  String texto = "Carregando...";
  String livro = "john";
  int capitulo = 3;
  String versao = "kjv"; // padrão inglês

  @override
  void initState() {
    super.initState();
    carregarProgresso();
  }

  // 🔥 BUSCAR VERSÍCULO
  Future<void> buscarVersiculo() async {
    final response = await http.get(
      Uri.parse(
        "https://bible-api.com/${livro.replaceAll(" ", "%20")}+$capitulo?translation=$versao",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      String resultado = "";

      for (var v in data["verses"]) {
        resultado += "${v["verse"]}. ${v["text"]}\n\n";
      }

      setState(() {
        texto = resultado;
      });
    }
  }

  // 💾 SALVAR PROGRESSO
  Future<void> salvarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('livro', livro);
    await prefs.setInt('capitulo', capitulo);
  }

  // 🔄 CARREGAR PROGRESSO
  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      livro = prefs.getString('livro') ?? "john";
      capitulo = prefs.getInt('capitulo') ?? 3;
    });

    buscarVersiculo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$livro $capitulo"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 📚 SELEÇÃO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: livro,
                  items:
                      [
                            "genesis",
                            "exodus",
                            "leviticus",
                            "numbers",
                            "deuteronomy",
                            "joshua",
                            "judges",
                            "ruth",
                            "1 samuel",
                            "2 samuel",
                            "1 kings",
                            "2 kings",
                            "1 chronicles",
                            "2 chronicles",
                            "ezra",
                            "nehemiah",
                            "esther",
                            "job",
                            "psalms",
                            "proverbs",
                            "ecclesiastes",
                            "song of solomon",
                            "isaiah",
                            "jeremiah",
                            "lamentations",
                            "ezekiel",
                            "daniel",
                            "hosea",
                            "joel",
                            "amos",
                            "obadiah",
                            "jonah",
                            "micah",
                            "nahum",
                            "habakkuk",
                            "zephaniah",
                            "haggai",
                            "zechariah",
                            "malachi",
                            "matthew",
                            "mark",
                            "luke",
                            "john",
                            "acts",
                            "romans",
                            "1 corinthians",
                            "2 corinthians",
                            "galatians",
                            "ephesians",
                            "philippians",
                            "colossians",
                            "1 thessalonians",
                            "2 thessalonians",
                            "1 timothy",
                            "2 timothy",
                            "titus",
                            "philemon",
                            "hebrews",
                            "james",
                            "1 peter",
                            "2 peter",
                            "1 john",
                            "2 john",
                            "3 john",
                            "jude",
                            "revelation",
                          ]
                          .map(
                            (l) => DropdownMenuItem(value: l, child: Text(l)),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      livro = value!;
                    });
                    buscarVersiculo();
                    salvarProgresso();
                  },
                ),
                DropdownButton<String>(
                  value: versao,
                  items: const [
                    DropdownMenuItem(value: "kjv", child: Text("🇺🇸 Inglês")),
                    DropdownMenuItem(
                      value: "almeida",
                      child: Text("🇧🇷 Português"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      versao = value!;
                    });
                    buscarVersiculo();
                  },
                ),

                DropdownButton<int>(
                  value: capitulo,
                  items: List.generate(50, (index) => index + 1)
                      .map(
                        (c) =>
                            DropdownMenuItem(value: c, child: Text("Cap $c")),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      capitulo = value!;
                    });
                    buscarVersiculo();
                    salvarProgresso();
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 📖 TEXTO
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  texto,
                  style: const TextStyle(fontSize: 18, height: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ⬅️➡️ BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (capitulo > 1) {
                      setState(() {
                        capitulo--;
                      });
                      buscarVersiculo();
                      salvarProgresso();
                    }
                  },
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      capitulo++;
                    });
                    buscarVersiculo();
                    salvarProgresso();
                  },
                  child: const Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),

      // 📱 NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Leitura",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
    );
  }
}
