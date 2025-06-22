import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'calendarPage.dart';
import 'cadastro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;
  String email = "";
  String senha = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month, size: 80, color: Colors.pinkAccent),
              SizedBox(height: 16),
              Text(
                'Calendário de Tarefas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                onChanged: (text) => email = text,
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
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (text) => senha = text,
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
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _logar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  'Não é registrado? Registre-se aqui.',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logar() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage())
      );
    } catch (e) {
      _mensagemErro("Usuário e/ou senha inválido(s).");/*${e.toString()}*/
    }
  }

  void _mensagemErro(String mensagem) {
    showDialog(
      context: context,
      builder: (contexto) => AlertDialog(
        title: Text('Erro'),
        content: Text(mensagem),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fechar')
          )
        ],
      ),
    );
  }

}
