import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:formulario/data/carrega_dados.dart';

class EnderecoPage extends StatefulWidget {
  final TextEditingController enderecoController;
  final TextEditingController bairroController;
  final TextEditingController estadoController;
  final TextEditingController cidadeController;

  const EnderecoPage(
      {super.key,
      required this.enderecoController,
      required this.bairroController,
      required this.estadoController,
      required this.cidadeController});

  @override
  EnderecoPageState createState() => EnderecoPageState();
}

class EnderecoPageState extends State<EnderecoPage> {
  String? _estadoSelecionado;

  late List<Map<String, dynamic>> _estados = [];
  List<String> municipiosCarregados = [];

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  List<String> filtraMunicipios(
      List<Map<String, dynamic>> municipios, int estadoId) {
    final List<String> listaMunicipios = [];

    municipios.forEach((municipio) {
      if (int.parse(municipio['id']) == estadoId) {
        listaMunicipios.add(municipio['nome']);
      }
    });

    return listaMunicipios;
  }

  void _carregaCidades() async {
    final municipios = await carregaMunicipiosJson();
    final estadoId = getIdEstado(_estadoSelecionado!);
    final listaMunicipios = filtraMunicipios(municipios, estadoId!);
    setState(() {
      municipiosCarregados = listaMunicipios;
    });
  }

  Future<void> _loadEstados() async {
    final estados = await carregaEstadosJson();
    setState(() {
      _estados = estados;
    });
  }

  int? getIdEstado(String nomeEstado) {
    for (var state in _estados) {
      if (state['nome'] == nomeEstado) {
        return state['id'];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.enderecoController,
            decoration: const InputDecoration(
                labelText: 'Rua', hintText: "Rua blablabla, 123"),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, informe sua rua';
              }
              return null;
            },
          ),
          TextFormField(
            controller: widget.bairroController,
            decoration: const InputDecoration(labelText: 'Bairro'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira seu bairro';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Selecione o estado'),
            value: _estadoSelecionado,
            items: _estados.map((estado) {
              return DropdownMenuItem<String>(
                value: estado['nome'],
                child: Text(estado['nome']),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _estadoSelecionado = newValue;
                widget.estadoController.text = newValue ?? '';
                if (newValue != null) _carregaCidades();
              });
            },
            validator: (value) =>
                value == null ? 'Por favor, selecione um estado' : null,
          ),
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            items: municipiosCarregados,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Cidade",
                hintText: "Cidade",
              ),
            ),
            onChanged: (value) {
              print("cidade search {$value}");
              setState(() {
                widget.cidadeController.text = value ?? '';
              });
            },
            selectedItem: "Curitiba",
          ),
        ],
      ),
    );
  }
}
