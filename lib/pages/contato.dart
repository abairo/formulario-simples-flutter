import 'package:flutter/material.dart';

class ContatoPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController telefoneController;

  const ContatoPage(
      {super.key,
      required this.emailController,
      required this.telefoneController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira seu email';
              }
              if (_validaEmail(value)) {
                return 'Por favor, insira um email válido';
              }
              return null;
            },
          ),
          TextFormField(
            controller: telefoneController,
            decoration:
                const InputDecoration(labelText: 'Telefone fixo ou Celular'),
            validator: (value) {
              if (value!.isEmpty) return 'Por favor, insira seu telefone';
              return null;
            },
          ),
        ],
      ),
    );
  }

  bool _validaEmail(String email) {
    return !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}
