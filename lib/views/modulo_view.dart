import 'package:flutter/material.dart';
import 'aula_view.dart';

class ModuloView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 1'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Aula 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AulaView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
