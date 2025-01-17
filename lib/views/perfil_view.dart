import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/user_controller.dart';
import 'login_view.dart';
import 'editarPerfil_view.dart';

class PerfilView extends StatefulWidget {
  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final UserController _userController = UserController();
  int? userId; // Variável para armazenar o ID do usuário
  Map<String, String?> user = {};

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId'); // Carrega o ID do usuário
    user = await _userController.getUserInfo(userId!);
    setState(() {});
  }

  void _navegarParaEditarPerfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    
    if (userId != null) { // Verifica se userId não é nulo
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditarPerfilView(userId: userId!)), // Usa userId com '!'
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ID do usuário não encontrado.')),
      );
    }
  }


  void _logout(BuildContext context) async {
    await _userController.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void _deleteProfile(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Perfil'),
          content: Text('Você tem certeza de que deseja excluir seu perfil?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Não exclui
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirma exclusão
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _userController.deleteUser(userId!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final name = user['name'] ?? 'Nome não disponível';
    final email = user['email'] ?? 'Email não disponível';

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _navegarParaEditarPerfil,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Nome: $name', style: TextStyle(fontSize: 24)),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _deleteProfile(context),
              child: Text('Excluir Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
