import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/user_controller.dart';
import 'login_view.dart';

class EditarPerfilView extends StatefulWidget {
  final int userId;

  EditarPerfilView({required this.userId});

  @override
  _EditarPerfilViewState createState() => _EditarPerfilViewState();
}

class _EditarPerfilViewState extends State<EditarPerfilView> {
  final UserController userController = UserController();
  late String nome;
  late String email;
  final _formKey = GlobalKey<FormState>();
  late String senha;

  @override
  void initState() {
    super.initState();
    _carregarInformacoesUsuario();
  }

  Future<void> _carregarInformacoesUsuario() async {
    Map<String, String?> usuarioInfo = await userController.getUserInfo(widget.userId);
    setState(() {
      nome = usuarioInfo['name'] ?? '';
      email = usuarioInfo['email'] ?? '';
    });
  }

  Future<void> _salvarInformacoes() async {
    if (_formKey.currentState!.validate()) {
      // Atualiza as informações do usuário
      await userController.registerUser(nome, email, senha, widget.userId);
      Navigator.pop(context); // Volta para a tela de perfil
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  nome = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu nome.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Por favor, insira um email válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarInformacoes,
                child: Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
