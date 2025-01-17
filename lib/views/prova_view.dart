import 'package:flutter/material.dart';

class ProvaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prova'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Pergunta: Qual é a nota?'),
            ElevatedButton(
              child: Text('Resposta 1'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Resposta 2'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Resposta 3'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
