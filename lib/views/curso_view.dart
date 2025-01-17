import 'package:flutter/material.dart';
import 'modulo_view.dart';

class CursoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curso 1'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Módulo 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModuloView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
