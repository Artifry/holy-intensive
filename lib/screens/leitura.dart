import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeituraPage extends StatefulWidget {
  const LeituraPage({super.key});

  @override
  State<LeituraPage> createState() => _LeituraPageState();
}

class _LeituraPageState extends State<LeituraPage>
    with SingleTickerProviderStateMixin {
  String texto = "Carregando...";
  String livro = "genesis";
  int capitulo = 1;
  String idioma = "pt";
  String statusSync = "offline";

  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> listaLivros = [
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
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);

    iniciar();
  }

  Future<void> iniciar() async {
    await carregarPreferencias();
    buscarVersiculo(); // 🔥 por enquanto fake
    sincronizarDados();
  }

  Future<void> carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    livro = prefs.getString('livro') ?? "genesis";
    capitulo = prefs.getInt('capitulo') ?? 1;
    idioma = prefs.getString('idioma') ?? "pt";

    if (!listaLivros.contains(livro)) {
      livro = "genesis";
    }
  }

  // 🔥 TEMPORÁRIO (até você criar JSON da bíblia)
  void buscarVersiculo() {
    setState(() {
      texto =
          "📖 $livro capítulo $capitulo\n\n(Conteúdo da Bíblia será carregado localmente depois)";
    });
  }

  Future<void> salvarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('livro', livro);
    await prefs.setInt('capitulo', capitulo);
  }

  Future<void> sincronizarDados() async {
    setState(() {
      statusSync = "syncando";
    });

    _controller.repeat(reverse: true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      statusSync = "online";
    });

    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$livro $capitulo"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: statusSync == "syncando"
                ? FadeTransition(
                    opacity: _animation,
                    child: const Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 14,
                    ),
                  )
                : Icon(
                    Icons.circle,
                    color: statusSync == "online" ? Colors.green : Colors.red,
                    size: 14,
                  ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: livro,
                    items: listaLivros
                        .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                        .toList(),
                    onChanged: (value) {
                      setState(() => livro = value!);
                      buscarVersiculo();
                      salvarProgresso();
                    },
                  ),
                ),

                const SizedBox(width: 10),

                DropdownButton<int>(
                  value: capitulo,
                  items: List.generate(50, (i) => i + 1)
                      .map((c) => DropdownMenuItem(value: c, child: Text("$c")))
                      .toList(),
                  onChanged: (value) {
                    setState(() => capitulo = value!);
                    buscarVersiculo();
                    salvarProgresso();
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
                    if (capitulo > 1) {
                      setState(() => capitulo--);
                      buscarVersiculo();
                      salvarProgresso();
                    }
                  },
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => capitulo++);
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
    );
  }
}
