import 'package:flutter/material.dart';
import '../services/bible_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String texto = "Carregando...";

  @override
  void initState() {
    super.initState();
    carregarVersiculo();
  }

  void carregarVersiculo() async {
    final data = await BibleService.getVerse("john+3:16");

    setState(() {
      texto = data["text"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Holy Intensive")),
      body: Center(child: Text(texto)),
    );
  }
}
