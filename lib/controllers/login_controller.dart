import 'user_controller.dart';
import 'package:flutter/material.dart';
import '../views/menu_view.dart';

class LoginController {
  final UserController _userController = UserController();

  Future<void> login(String email, String password, BuildContext context) async {
    // Verifica se o usuário está cadastrado
    int userId = await _userController.getUserId(email);
    if (userId == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário não cadastrado.')),
      );
      return;
    }

    // Lógica para verificar a senha
    bool success = await _userController.loginUser(email, password);
    if (success) {
      // Navega para a tela de menu
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuView()), // Redireciona para a tela de menu
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email ou senha incorretos.')),
      );
    }
  }
}
