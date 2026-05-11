import 'package:flutter/material.dart';
import 'quiz.dart';

class LeituraPage extends StatelessWidget {
  const LeituraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leitura')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('João 3:16 - Porque Deus amou o mundo...'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              child: const Text('Marcar como lido'),
            ),
          ],
        ),
      ),
    );
  }
}
