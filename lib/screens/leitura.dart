import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$livro $capitulo"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: livro,
                  items:
                      [
                            // Antigo Testamento
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

                            // Novo Testamento
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
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

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

      // 👇 navegação do app
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
