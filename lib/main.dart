import 'package:flutter/material.dart';
import 'views/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cursos Musicais',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginView(),
    );
  }
}
