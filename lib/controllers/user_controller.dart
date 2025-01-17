import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  Future<void> registerUser(String name, String email, String password, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? existingUsers = prefs.getString('users') ?? '';

    existingUsers += '$userId,$email,$password,$name;';
    await prefs.setString('users', existingUsers);
  }

  Future<Map<String, String?>> getUserInfo(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? existingUsers = prefs.getString('users');
    Map<String, String?> userData = {};

    if (existingUsers != null) {
      List<String> users = existingUsers.split(';');
      for (var user in users) {
        if (user.isNotEmpty) {
          List<String> userInfo = user.split(',');
          if (int.parse(userInfo[0]) == userId) {
            userData['id'] = userInfo[0];
            userData['email'] = userInfo[1];
            userData['name'] = userInfo[3]; // O nome é o quarto item
            break;
          }
        }
      }
    }
    return userData;
  }

  Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? existingUsers = prefs.getString('users');
    if (existingUsers != null) {
      List<String> users = existingUsers.split(';');
      for (var user in users) {
        if (user.isNotEmpty) {
          List<String> userInfo = user.split(',');
          if (userInfo[1] == email && userInfo[2] == password) {
            // Armazena o ID do usuário no SharedPreferences
            await prefs.setInt('userId', int.parse(userInfo[0]));
            return true; // Login bem-sucedido
          }
        }
      }
    }
    return false;
  }

  Future<int> getUserId(String email) async {
    final prefs = await SharedPreferences.getInstance();
    String? existingUsers = prefs.getString('users');
    if (existingUsers != null) {
      List<String> users = existingUsers.split(';');
      for (var user in users) {
        if (user.isNotEmpty) {
          List<String> userInfo = user.split(',');
          if (userInfo[1] == email) {
            return int.parse(userInfo[0]); // Retorna o ID do usuário
          }
        }
      }
    }
    return -1; // Retorna -1 se o usuário não for encontrado
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId'); // Remove o ID do usuário
  }

  Future<void> deleteUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? existingUsers = prefs.getString('users') ?? '';
    List<String> users = existingUsers.split(';');

    // Remove o usuário com o ID correspondente
    users.removeWhere((user) => user.startsWith('$userId,'));

    // Salva a lista atualizada de usuários
    await prefs.setString('users', users.join(';'));
    await logout(); // Faz logout após a exclusão
  }
}
