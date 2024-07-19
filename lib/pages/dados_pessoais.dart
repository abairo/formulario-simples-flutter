import 'package:flutter/material.dart';

class DadosPessoaisPage extends StatefulWidget {
  final TextEditingController nomeController;
  final TextEditingController nomeSocialController;
  final TextEditingController dataNascimentoController;

  const DadosPessoaisPage(
      {super.key,
      required this.nomeController,
      required this.nomeSocialController,
      required this.dataNascimentoController});

  @override
  DadosPessoaisPageState createState() => DadosPessoaisPageState();
}

class DadosPessoaisPageState extends State<DadosPessoaisPage> {
  String? _possuiNomeSocial = 'Não';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira seu nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Você possui nome social?'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio<String>(
                value: 'Sim',
                groupValue: _possuiNomeSocial,
                onChanged: (value) {
                  setState(() {
                    _possuiNomeSocial = value;
                  });
                },
              ),
              const Text('Sim'),
              Radio<String>(
                value: 'Não',
                groupValue: _possuiNomeSocial,
                onChanged: (value) {
                  setState(() {
                    _possuiNomeSocial = value;
                  });
                },
              ),
              const Text('Não'),
            ],
          ),
          if (_possuiNomeSocial == 'Sim')
            TextFormField(
              controller: widget.nomeSocialController,
              decoration: const InputDecoration(labelText: 'Nome social'),
              validator: (value) {
                if (value!.isEmpty) return null;
                if (value.length < 3) {
                  return 'Por favor, insira seu nome social';
                }
                return null;
              },
            ),
          TextFormField(
            controller: widget.dataNascimentoController,
            onTap: () async {
              var data = await showDatePicker(
                  context: context,
                  initialDate: DateTime(1990, 1, 1),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());
              widget.dataNascimentoController.text =
                  data != null ? data.toString() : "";
            },
            decoration: const InputDecoration(labelText: 'Data de nascimento'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira sua data de nascimento';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
