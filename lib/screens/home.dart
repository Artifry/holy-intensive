ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeituraPage()),
    );
  },
  child: Text('Começar leitura'),
)