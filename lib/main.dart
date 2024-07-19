import 'package:flutter/material.dart';
import 'package:formulario/pages/contato.dart';
import 'package:formulario/pages/dados_pessoais.dart';
import 'package:formulario/pages/endereco.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de cadastro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormularioPage(),
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  FormularioPageState createState() => FormularioPageState();
}

class FormularioPageState extends State<FormularioPage> {
  final _formularioKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final PageController _controladorPagina = PageController();
  int _paginaInicial = 0;

  // Dados Pessoais
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nomeSocialController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  // Contato
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  // Endereço
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();

  final List<String> _tituloPaginas = [
    'Informações Pessoais',
    'Contato',
    'Endereço',
  ];

  void _proximaPagina() {
    if (_formularioKeys[_paginaInicial].currentState!.validate()) {
      _formularioKeys[_paginaInicial].currentState!.save();
      if (_paginaInicial < 2) {
        _controladorPagina.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        setState(() {
          _paginaInicial++;
        });
      } else {
        _submitForm();
      }
    }
  }

  void _paginaAnterior() {
    if (_paginaInicial > 0) {
      _controladorPagina.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _paginaInicial--;
      });
    }
  }

  void _submitForm() {
    final dadosFormulario = {
      'nome': _nomeController.text,
      "nomeSocial": _nomeSocialController.text,
      "dataNascimento": _dataNascimentoController.text,
      'email': _emailController.text,
      'telefone': _telefoneController.text,
      'rua': _enderecoController.text,
      'bairro': _bairroController.text,
      'estado': _estadoController.text,
      'cidade': _cidadeController.text,
    };
    print('Dados do formulário: $dadosFormulario');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _tituloPaginas[_paginaInicial],
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green),
      body: PageView(
        controller: _controladorPagina,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _paginaInicial = index;
          });
        },
        children: [
          Form(
            key: _formularioKeys[0],
            child: DadosPessoaisPage(
              nomeController: _nomeController,
              nomeSocialController: _nomeSocialController,
              dataNascimentoController: _dataNascimentoController,
            ),
          ),
          Form(
            key: _formularioKeys[1],
            child: ContatoPage(
              emailController: _emailController,
              telefoneController: _telefoneController,
            ),
          ),
          Form(
            key: _formularioKeys[2],
            child: EnderecoPage(
              enderecoController: _enderecoController,
              bairroController: _bairroController,
              estadoController: _estadoController,
              cidadeController: _cidadeController,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_paginaInicial > 0)
              TextButton(
                onPressed: _paginaAnterior,
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 4),
                    Text("Anterior"),
                  ],
                ),
              ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: _proximaPagina,
              child: Row(
                children: [
                  Text(_paginaInicial < 2 ? "Próximo" : "Concluir"),
                  const SizedBox(width: 4),
                  Icon(_paginaInicial < 2 ? Icons.arrow_forward : Icons.send),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
