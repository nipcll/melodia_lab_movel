import 'package:flutter/material.dart';
import 'prova_view.dart';

class AulaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aula 1'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Avaliação 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProvaView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
