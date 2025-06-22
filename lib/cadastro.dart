import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String senha = '';
  final _formKey = GlobalKey<FormState>();

  void _registrar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Sucesso'),
            content: Text('Cadastro realizado com sucesso!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        _mostrarErro("Erro ao tentar realizar o cadastro, por favor, verifique as informações e tente novamente.");/*${e.toString()}*/
      }
    }
  }

  void _mostrarErro(String mensagem) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erro'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar para Login',
        ),
        title: Text('Cadastrar'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add, size: 80, color: Colors.pinkAccent),
                SizedBox(height: 16),
                Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(height: 32),
                TextFormField(
                  onChanged: (value) => email = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.pink),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Informe um email válido' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  onChanged: (value) => senha = value,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock, color: Colors.pink),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) => value!.length < 6
                      ? 'A senha deve ter ao menos 6 caracteres'
                      : null,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _registrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    child: Text(
                      'Registrar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
