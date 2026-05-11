import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String resultado = '';

  void verificarResposta(String resposta) async {
    if (resposta == 'certa') {
      await FirebaseFirestore.instance.collection('users').add({
        'xp': 10,
        'data': DateTime.now(),
      });

      setState(() {
        resultado = '✅ Acertou! +10 XP';
      });
    } else {
      setState(() {
        resultado = '❌ Errou!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quem Deus amou?'),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => verificarResposta('certa'),
              child: const Text('O mundo'),
            ),

            ElevatedButton(
              onPressed: () => verificarResposta('errada'),
              child: const Text('Apenas Israel'),
            ),

            const SizedBox(height: 20),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}
